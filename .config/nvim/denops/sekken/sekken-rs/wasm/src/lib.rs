use std::collections::HashMap;

use anyhow::anyhow;
use anyhow::Context as _;
use serde_wasm_bindgen::Error;
use wasm_bindgen::prelude::*;

use sekken_core::dictionary;
use sekken_core::kana;
use sekken_core::sekken;
use sekken_model::compact::CompactModel;

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
pub fn use_default_kana_table() -> Result<(), JsError> {
    let kana_table = kana::KanaTable::default_table().context("failed to load default kana table");
    match kana_table {
        Ok(kana_table) => {
            replace_kana_table(kana_table);
            Ok(())
        }
        Err(e) => Err(JsError::new(&format!("{:?}", e))),
    }
}

#[wasm_bindgen]
pub fn set_kana_table(map: JsValue) -> Result<(), JsError> {
    let map: Result<HashMap<String, String>, Error> = serde_wasm_bindgen::from_value(map);
    let map = map.map_err(|e| anyhow!("{:?}", e).context("failed to parse kana table"));
    let kana_table =
        map.and_then(|map| kana::KanaTable::new(map).context("failed to load kana table"));
    match kana_table {
        Ok(kana_table) => {
            replace_kana_table(kana_table);
            Ok(())
        }
        Err(e) => Err(JsError::new(&format!("{:?}", e))),
    }
}

fn replace_skk_dictionary(dict: dictionary::SKKDictionary) {
    SEKKEN.with(|sekken| {
        sekken.replace_dictionary(dict);
    });
}

#[wasm_bindgen]
pub fn set_skk_dictionary(dict: JsValue) -> Result<(), JsError> {
    let dict: dictionary::SKKDictionary = serde_wasm_bindgen::from_value(dict)?;
    replace_skk_dictionary(dict);
    Ok(())
}

#[wasm_bindgen]
pub fn set_model(data: &[u8]) -> Result<(), JsError> {
    let model = CompactModel::load(data).context("failed to load model");
    match model {
        Ok(model) => {
            SEKKEN.with(|sekken| {
                sekken.replace_model(model);
            });
            Ok(())
        }
        Err(e) => Err(JsError::new(&format!("{:?}", e))),
    }
}

#[wasm_bindgen]
pub fn henkan(roman: String, n: usize) -> Result<Vec<String>, JsError> {
    let result = SEKKEN.with(|sekken| sekken.viterbi_henkan(roman, n).context("failed to henkan"));
    match result {
        Ok(result) => Ok(result),
        Err(e) => Err(JsError::new(&format!("{:?}", e))),
    }
}
