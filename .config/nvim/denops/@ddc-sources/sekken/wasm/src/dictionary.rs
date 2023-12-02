use serde::{Deserialize, Serialize};

use std::collections::HashMap;

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct SKKDictionary {
    pub okuri_ari: HashMap<String, Vec<String>>,
    pub okuri_nasi: HashMap<String, Vec<String>>,
}
