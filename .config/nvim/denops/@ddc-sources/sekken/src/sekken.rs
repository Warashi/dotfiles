use crate::dictionary::SKKDictionary;
use crate::kana::KanaTable;

use std::cell::RefCell;

pub struct Sekken {
    pub kana_table: RefCell<Option<KanaTable>>,
    pub dictionary: RefCell<Option<SKKDictionary>>,
}

impl Sekken {
    pub fn new() -> Sekken {
        Sekken {
            kana_table: RefCell::new(None),
            dictionary: RefCell::new(None),
        }
    }

    pub fn replace_kana_table(&self, kana_table: KanaTable) {
        self.kana_table.replace(Some(kana_table));
    }

    pub fn replace_dictionary(&self, dictionary: SKKDictionary) {
        self.dictionary.replace(Some(dictionary));
    }

    pub fn henkan(&self, roman: String) -> Vec<String> {
        let zenkaku = vec![self.zenkaku_henkan(roman.clone())];

        let idx = self.search_upper(roman.clone());
        match idx {
            Some(0) => self
                .kanji_henkan(roman.clone())
                .into_iter()
                .chain(zenkaku)
                .collect(),
            Some(i) => {
                let (hira, kanji) = roman.split_at(i);
                let hira = self.hira_kana_henkan(hira.to_string());
                let kanji = self.kanji_henkan(kanji.to_string());
                kanji
                    .into_iter()
                    .map(|s| hira.clone() + &s)
                    .chain(zenkaku)
                    .collect()
            }
            None => self.kana_henkan(roman).into_iter().chain(zenkaku).collect(),
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
        dict.okuri_nasi.get(&roman).unwrap().clone()
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
                let okuri_ari = self.okuri_ari_henkan(hira.to_string(), okuri.to_string());
                let okuri_nashi = self
                    .okuri_nasi_henkan(hira.to_string())
                    .into_iter()
                    .map(|s| s + &okuri);
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
            .unwrap()
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
            .unwrap()
            .clone()
            .into_iter()
            .map(|s| s + &okuri)
            .collect()
    }

    fn search_upper(&self, roman: String) -> Option<usize> {
        roman.chars().position(|c| c.is_uppercase())
    }
}
