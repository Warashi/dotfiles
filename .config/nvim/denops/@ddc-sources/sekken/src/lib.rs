mod kana;

use std::cell::RefCell;
use std::option::Option;
use wasm_bindgen::prelude::*;

thread_local! {
    static KANA_TABLE: RefCell<Option<kana::KanaTable<'static>>> = RefCell::new(None);
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

#[wasm_bindgen]
pub fn use_default_kana_table() {
    let kana_table = kana::KanaTable::default().unwrap();
    KANA_TABLE.replace(Some(kana_table));
}
