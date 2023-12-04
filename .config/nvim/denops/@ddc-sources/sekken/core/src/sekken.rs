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

    pub fn henkan(&self, roman: String) -> Vec<String> {
        let default = self
            .roman_henkan(roman.clone())
            .into_iter()
            .chain(vec![self.zenkaku_henkan(roman.clone())]);

        let idx = self.search_upper(roman.clone());
        match idx {
            Some(0) => self
                .kanji_henkan(roman.clone())
                .into_iter()
                .chain(default)
                .collect(),
            Some(i) => {
                let (hira, kanji) = roman.split_at(i);
                let hira = self.hira_kana_henkan(hira.to_string());
                let kanji = self.kanji_henkan(kanji.to_string());
                kanji
                    .into_iter()
                    .map(|s| hira.clone() + &s)
                    .chain(default)
                    .collect()
            }
            None => self.kana_henkan(roman).into_iter().chain(default).collect(),
        }
    }

    fn zenkaku_henkan(&self, roman: String) -> String {
        roman.chars().map(|c| self.zenkaku_henkan_char(c)).collect()
    }

    fn zenkaku_henkan_char(&self, c: char) -> char {
        if c.is_ascii() {
            char::from_u32(c as u32 + 0xFEE0).unwrap()
        } else {
            c
        }
    }

    fn roman_henkan(&self, roman: String) -> Vec<String> {
        let dict = self.dictionary.borrow();
        let dict = dict.as_ref().unwrap();
        dict.okuri_nasi.get(&roman).unwrap_or(&Vec::new()).clone()
    }

    fn kana_henkan(&self, roman: String) -> Vec<String> {
        let hira = self.hira_kana_henkan(roman);
        let kata = self.hira2kata(hira.clone());
        vec![hira, kata]
    }

    fn hira_kana_henkan(&self, roman: String) -> String {
        self.kana_table.borrow().as_ref().unwrap().roman2kana(roman)
    }

    fn hira2kata(&self, hira: String) -> String {
        hira.chars().map(|c| self.hira2kata_char(c)).collect()
    }

    fn hira2kata_char(&self, c: char) -> char {
        let code = c as u32;
        if 0x3041 <= code && code <= 0x3096 {
            char::from_u32(code + 0x60).unwrap()
        } else {
            c
        }
    }

    fn kanji_henkan(&self, roman: String) -> Vec<String> {
        let roman = roman[0..1].to_string().to_lowercase() + &roman[1..];
        match self.search_upper(roman.clone()) {
            Some(i) => {
                let (hira, okuri) = roman.split_at(i);
                let hira = self.hira_kana_henkan(hira.to_string());
                let okuri = okuri.to_lowercase();
                let okuri_hira = self.hira_kana_henkan(okuri.to_string());
                let okuri_ari = self.okuri_ari_henkan(hira.to_string(), okuri.to_string());
                let okuri_nashi = self
                    .okuri_nasi_henkan(hira.to_string())
                    .into_iter()
                    .map(|s| s + &okuri_hira);
                okuri_ari.into_iter().chain(okuri_nashi).collect()
            }
            None => self.okuri_nasi_henkan(roman),
        }
    }

    fn okuri_nasi_henkan(&self, roman: String) -> Vec<String> {
        let kana = self.hira_kana_henkan(roman);
        self.dictionary
            .borrow()
            .as_ref()
            .unwrap()
            .okuri_nasi
            .get(&kana)
            .unwrap_or(&Vec::new())
            .clone()
    }

    fn okuri_ari_henkan(&self, hira: String, okuri: String) -> Vec<String> {
        let alpha = okuri[0..1].to_string();
        let okuri = self.hira_kana_henkan(okuri);
        let key = hira + &alpha;
        self.dictionary
            .borrow()
            .as_ref()
            .unwrap()
            .okuri_ari
            .get(&key)
            .unwrap_or(&Vec::new())
            .clone()
            .into_iter()
            .map(|s| s + &okuri)
            .collect()
    }

    fn search_upper(&self, roman: String) -> Option<usize> {
        roman.chars().position(|c| c.is_uppercase())
    }

    fn split_upper(&self, roman: String) -> Vec<String> {
        let mut result = Vec::new();
        let mut roman = roman;
        loop {
            match self.search_upper(roman.clone()) {
                Some(i) => {
                    let (head, tail) = roman.split_at(i);
                    result.push(head.to_string());
                    roman = tail.to_string();
                }
                None => {
                    result.push(roman);
                    return result;
                }
            }
        }
    }

    fn viterbi_henkan(&self, roman: String, top_n: usize) -> Result<Vec<String>> {
        let default = self
            .roman_henkan(roman.clone())
            .into_iter()
            .chain(vec![self.zenkaku_henkan(roman.clone())]);

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
                let hira = self.hira_kana_henkan(words[0].clone());
                let lattice = self
                    .make_lattice(words.into_iter().skip(1).collect())
                    .context("make lattice")?;
                let model = self.model.borrow();
                let model = model.as_ref().context("model is not set")?;
                let result = lattice.viterbi(model, top_n).context("calculate viterbi")?;
                Ok(result.into_iter().map(|(_, s)| hira.clone() + &s).collect())
            }
            None => Ok(self.kana_henkan(roman).into_iter().chain(default).collect()),
        }
    }

    fn make_lattice(&self, words: Vec<String>) -> Result<lattice::Lattice> {
        let entries = words
            .clone()
            .into_iter()
            .zip(words.into_iter().chain(vec!["".to_string()]).skip(1))
            .map(|(kanji, kana)| self.get_candidates(kanji.clone(), kana.clone()))
            .enumerate()
            .map(|(i, s)| {
                s.into_iter()
                    .map(|s| {
                        let hans = s
                            .chars()
                            .into_iter()
                            .filter(|c| is_han(c.clone()))
                            .collect::<Vec<char>>();
                        let (head_han, tail_han) = (hans[0].clone(), hans[hans.len() - 1].clone());
                        lattice::Entry::new(Node::new(s, i as u8), head_han, tail_han)
                    })
                    .collect::<Vec<_>>()
            })
            .collect::<Vec<_>>();
        let lattice = lattice::Lattice::new(entries);
        Ok(lattice)
    }

    fn get_candidates(&self, kanji: String, kana: String) -> Vec<String> {
        if kana.is_empty() {
            self.okuri_nasi_henkan(kanji)
        } else {
            self.okuri_ari_henkan(kanji, kana)
        }
    }
}
