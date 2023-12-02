use serde::{Deserialize, Serialize};

use std::collections::HashMap;
use std::io::{Read, Write};

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Model {
    pub char_cost: HashMap<u32, u128>,
    pub bigram_cost: HashMap<u64, u128>,
}

impl Model {
    pub fn new<R: Read>(msgp: R) -> Result<Self, rmp_serde::decode::Error> {
        rmp_serde::from_read(msgp)
    }

    pub fn save<W: Write>(&self, mut writer: W) -> Result<(), rmp_serde::encode::Error> {
        rmp_serde::encode::write(&mut writer, self)
    }
}
