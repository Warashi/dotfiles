use serde::{Serialize, Deserialize};

use std::collections::HashMap;

#[derive(Serialize, Deserialize)]
pub struct SKKDictionary {
    pub okuri_ari: HashMap<String, Vec<String>>,
    pub okuri_nasi: HashMap<String, Vec<String>>,
}
