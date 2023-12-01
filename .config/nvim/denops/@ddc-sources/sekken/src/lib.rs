mod kana;

use std::cell::RefCell;
use std::collections::HashMap;
use std::option::Option;
use wasm_bindgen::prelude::*;

thread_local! {
    static KANA_TABLE: RefCell<Option<kana::KanaTable>> = RefCell::new(None);
}

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = console, js_name = log)]
    fn alert(s: &str);
}

#[wasm_bindgen]
pub fn init() {
    console_error_panic_hook::set_once();
}

#[wasm_bindgen]
pub fn roman2kana(roman: String) -> String {
    KANA_TABLE.with_borrow(|kana_table| {
        let kana_table = kana_table.as_ref().unwrap();
        kana_table.roman2kana(roman)
    })
}

fn set_kana_table(map: kana::KanaTable) {
    if let Some(map) = KANA_TABLE.replace(Some(map)) {
        drop(map);
    }
}

#[wasm_bindgen]
pub fn use_default_kana_table() {
    let kana_table = kana::KanaTable::default().unwrap();
    set_kana_table(kana_table);
}

#[wasm_bindgen]
pub fn use_kana_table(map: JsValue) {
    let map: HashMap<String, String> = serde_wasm_bindgen::from_value(map).unwrap();
    let kana_table = kana::KanaTable::new(map).unwrap();
    set_kana_table(kana_table);
}
