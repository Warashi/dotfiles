use std::cell::RefCell;

use anyhow::{Context, Result};

use sekken_model::compact::CompactModel;

use crate::dictionary::SKKDictionary;
use crate::kana::KanaTable;
use crate::util::is_han;
use crate::viterbi::Node;

mod lattice;

pub struct Sekken {
    kana_table: RefCell<Option<KanaTable>>,
    dictionary: RefCell<Option<SKKDictionary>>,
    model: RefCell<Option<CompactModel>>,
}

impl Default for Sekken {
    fn default() -> Self {
        Self::new()
    }
}

impl Sekken {
    pub fn new() -> Sekken {
        Sekken {
            kana_table: RefCell::new(None),
            dictionary: RefCell::new(None),
            model: RefCell::new(None),
        }
    }

    pub fn replace_kana_table(&self, kana_table: KanaTable) {
        self.kana_table.replace(Some(kana_table));
    }

    pub fn replace_dictionary(&self, dictionary: SKKDictionary) {
        self.dictionary.replace(Some(dictionary));
    }

    pub fn replace_model(&self, model: CompactModel) {
        self.model.replace(Some(model));
    }

    fn zenkaku_henkan(&self, roman: String) -> Result<String> {
        roman.chars().map(|c| self.zenkaku_henkan_char(c)).collect()
    }

    fn zenkaku_henkan_char(&self, c: char) -> Result<char> {
        if c.is_ascii() {
            char::from_u32(c as u32 + 0xFEE0).context("convert to zenkaku")
        } else {
            Ok(c)
        }
    }

    fn roman_henkan(&self, roman: String) -> Vec<String> {
        let dict = self.dictionary.borrow();
        dict.as_ref()
            .and_then(|d| d.okuri_nasi.get(&roman))
            .map_or(Vec::new(), |v| v.clone())
    }

    fn kana_henkan(&self, roman: String) -> Result<Vec<String>> {
        let hira = self
            .hira_kana_henkan(roman)
            .context("convert to hiragana")?;
        let kata = self
            .hira2kata(hira.clone())
            .context("convert to katakana")?;
        Ok(vec![hira, kata])
    }

    fn hira_kana_henkan(&self, roman: String) -> Result<String> {
        let table = self.kana_table.borrow();
        let table = table.as_ref().context("kana table is not set")?;
        Ok(table.roman2kana(roman))
    }

    fn hira2kata(&self, hira: String) -> Result<String> {
        hira.chars()
            .map(|c| self.hira2kata_char(c).context("convert to katakana"))
            .collect()
    }

    fn hira2kata_char(&self, c: char) -> Result<char> {
        let code = c as u32;
        if (0x3041..=0x3096).contains(&code) {
            char::from_u32(code + 0x60).context("convert to katakana")
        } else {
            Ok(c)
        }
    }

    fn okuri_nasi_henkan(&self, roman: String) -> Result<Vec<String>> {
        let kana = self
            .hira_kana_henkan(roman)
            .context("convert to hiragana")?;
        let dictionary = self.dictionary.borrow();
        let dictionary = dictionary.as_ref();
        let dictionary = dictionary.context("dictionary is not set")?;

        let result = dictionary
            .okuri_nasi
            .get(&kana)
            .cloned()
            .unwrap_or(Vec::new());
        Ok(result)
    }

    fn okuri_ari_henkan(&self, hira: String, okuri: String) -> Result<Vec<String>> {
        let alpha = okuri[0..1].to_string();
        let okuri = self
            .hira_kana_henkan(okuri)
            .context("convert to hiragana")?;
        let key = hira + &alpha;

        let dictionary = self.dictionary.borrow();
        let dictionary = dictionary.as_ref();
        let dictionary = dictionary.context("dictionary is not set")?;

        let result = dictionary
            .okuri_ari
            .get(&key)
            .map(|v| v.iter().cloned().map(|s| s + &okuri).collect())
            .unwrap_or(Vec::new());

        Ok(result)
    }

    fn search_upper(&self, roman: String) -> Option<usize> {
        roman.chars().position(|c| c.is_uppercase())
    }

    fn split_upper(&self, roman: String) -> Vec<String> {
        let mut words = Vec::new();
        let mut word = String::new();
        for c in roman.chars() {
            if c.is_uppercase() {
                if !word.is_empty() {
                    words.push(word);
                }
                word = c.to_string();
            } else {
                word += &c.to_string();
            }
        }
        if !word.is_empty() {
            words.push(word);
        }
        words
    }

    pub fn viterbi_henkan(&self, roman: String, top_n: usize) -> Result<Vec<String>> {
        let words = self.split_upper(roman.clone());
        match self.search_upper(roman.clone()) {
            Some(0) => {
                let lattice = self.make_lattice(words).context("make lattice")?;
                let model = self.model.borrow();
                let model = model.as_ref().context("model is not set")?;
                let result = lattice.viterbi(model, top_n).context("calculate viterbi")?;
                Ok(result.into_iter().map(|(_, s)| s).collect())
            }
            Some(_) => {
                let hira = self.hira_kana_henkan(words[0].clone()).unwrap_or_default();
                let lattice = self
                    .make_lattice(words.into_iter().skip(1).collect())
                    .context("make lattice")?;
                let model = self.model.borrow();
                let model = model.as_ref().context("model is not set")?;
                let result = lattice.viterbi(model, top_n).context("calculate viterbi")?;
                Ok(result.into_iter().map(|(_, s)| hira.clone() + &s).collect())
            }
            None => {
                let kana = self.kana_henkan(roman.clone()).context("kana henkan")?;
                Ok(kana)
            }
        }
    }

    fn make_lattice(&self, words: Vec<String>) -> Result<lattice::Lattice> {
        let entries = words
            .clone()
            .into_iter()
            .zip(words.into_iter().chain(vec!["".to_string()]).skip(1))
            .enumerate()
            .filter(|(i, _)| i % 2 == 0)
            .map(|(_, (kanji, kana))| self.get_candidates(kanji.clone(), kana.clone()))
            .map(|s| {
                s.into_iter()
                    .map(|(i, s)| {
                        let hans = s.chars().filter(|c| is_han(*c)).collect::<Vec<char>>();
                        if hans.is_empty() {
                            return lattice::Entry::new(Node::new(s, i as u8), '\0', '\0');
                        }
                        let (head_han, tail_han) = (hans[0], hans[hans.len() - 1]);
                        lattice::Entry::new(Node::new(s, i as u8), head_han, tail_han)
                    })
                    .collect::<Vec<_>>()
            })
            .collect::<Vec<_>>();
        let lattice = lattice::Lattice::new(entries);
        Ok(lattice)
    }

    fn get_candidates(&self, kanji: String, okuri: String) -> Vec<(usize, String)> {
        let (kanji, okuri) = (kanji.to_lowercase(), okuri.to_lowercase());
        if okuri.is_empty() {
            self.okuri_nasi_henkan(kanji.clone())
                .unwrap_or_default()
                .into_iter()
                .chain(self.kana_henkan(kanji.clone()).unwrap_or_default())
                .chain(self.roman_henkan(kanji.clone()))
                .chain(
                    self.zenkaku_henkan(kanji.clone())
                        .map_or(Vec::new(), |s| vec![s]),
                )
                .enumerate()
                .collect()
        } else {
            let kanji = self.hira_kana_henkan(kanji.to_string()).unwrap_or_default();
            let okuri = okuri.to_lowercase();
            let okuri_hira = self.hira_kana_henkan(okuri.to_string()).unwrap_or_default();
            let okuri_ari = self.okuri_ari_henkan(kanji.to_string(), okuri.to_string());
            let okuri_nashi = self
                .okuri_nasi_henkan(kanji.to_string())
                .unwrap_or_default()
                .into_iter()
                .chain(self.kana_henkan(kanji.clone()).unwrap_or_default())
                .chain(self.roman_henkan(kanji.clone()))
                .chain(
                    self.zenkaku_henkan(kanji.clone())
                        .map_or(Vec::new(), |s| vec![s]),
                )
                .map(|s| s + &okuri_hira)
                .enumerate();
            okuri_ari
                .unwrap_or_default()
                .into_iter()
                .enumerate()
                .chain(okuri_nashi)
                .collect()
        }
    }
}
