use std::collections::HashMap;
use std::io::{Read, Write};

use anyhow::Context as _;
use anyhow::Result;
use serde::{Deserialize, Serialize};
use zstd::stream::{Decoder, Encoder};

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct CompactModel {
    pub unigram_cost: HashMap<u32, u8>,
    pub bigram_cost: HashMap<u64, u8>,
}

impl CompactModel {
    pub fn new() -> Self {
        Self {
            unigram_cost: HashMap::new(),
            bigram_cost: HashMap::new(),
        }
    }

    pub fn load<R: Read>(reader: R) -> Result<Self> {
        let reader = Decoder::new(reader).context("Failed to initialize decoder")?;
        let model = rmp_serde::from_read(reader).context("Failed to load model")?;
        Ok(model)
    }

    pub fn save<W: Write>(&self, writer: W) -> Result<()> {
        let mut writer = Encoder::new(writer, 22).context("Failed to initialize encoder")?;
        rmp_serde::encode::write(&mut writer, self).context("Failed to save model")?;
        writer.finish().context("Failed to finish encoder")?;
        Ok(())
    }

    pub fn get_unigram_cost(&self, c: char) -> u8 {
        *self.unigram_cost.get(&(c as u32)).unwrap_or(&255)
    }

    pub fn get_bigram_cost(&self, c1: char, c2: char) -> u8 {
        *self
            .bigram_cost
            .get(&((c1 as u64) << 32 | c2 as u64))
            .unwrap_or(&255)
    }

    pub(crate) fn set_unigram_cost(&mut self, key: u32, cost: u8) {
        self.unigram_cost.insert(key, cost);
    }

    pub(crate) fn set_bigram_cost(&mut self, key: u64, cost: u8) {
        self.bigram_cost.insert(key, cost);
    }
}
