use std::collections::HashMap;

use wasm_bindgen::prelude::*;

use sekken_core::dictionary;
use sekken_core::kana;
use sekken_core::sekken;

thread_local! {
    static SEKKEN: sekken::Sekken = sekken::Sekken::new();
}

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = console, js_name = log)]
    pub fn alert(s: &str);
}

#[wasm_bindgen]
pub fn init() {
    console_error_panic_hook::set_once();
}

fn replace_kana_table(map: kana::KanaTable) {
    SEKKEN.with(|sekken| {
        sekken.replace_kana_table(map);
    });
}

#[wasm_bindgen]
pub fn use_default_kana_table() {
    let kana_table = kana::KanaTable::default().unwrap();
    replace_kana_table(kana_table);
}

#[wasm_bindgen]
pub fn set_kana_table(map: JsValue) {
    let map: HashMap<String, String> = serde_wasm_bindgen::from_value(map).unwrap();
    let kana_table = kana::KanaTable::new(map).unwrap();
    replace_kana_table(kana_table);
}

fn replace_skk_dictionary(dict: dictionary::SKKDictionary) {
    SEKKEN.with(|sekken| {
        sekken.replace_dictionary(dict);
    });
}

#[wasm_bindgen]
pub fn set_skk_dictionary(dict: JsValue) {
    let dict: dictionary::SKKDictionary = serde_wasm_bindgen::from_value(dict).unwrap();
    replace_skk_dictionary(dict);
}

#[wasm_bindgen]
pub fn henkan(roman: String) -> Vec<String> {
    SEKKEN.with(|sekken| sekken.henkan(roman))
}
