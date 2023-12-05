use std::collections::BTreeMap;
use std::io::{Read, Write};

use anyhow::Context as _;
use anyhow::Result;
use capnp::message::{Builder, ReaderOptions};
use capnp::serialize;
use serde::{Deserialize, Serialize};
use zstd::stream::{Decoder, Encoder};

use crate::compact_capnp::compact_model;

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct CompactModel {
    bigram_cost: BTreeMap<u64, u8>,
}

impl CompactModel {
    pub fn new() -> Self {
        Self {
            bigram_cost: BTreeMap::new(),
        }
    }

    pub fn load<R: Read>(reader: R) -> Result<Self> {
        let reader = Decoder::new(reader).context("Failed to initialize decoder")?;
        let reader = serialize::read_message(
            reader,
            ReaderOptions {
                traversal_limit_in_words: None,
                nesting_limit: i32::MAX,
            },
        )
        .context("Failed to read message")?;
        let reader = reader
            .get_root::<compact_model::Reader>()
            .context("Failed to get root")?;

        let entries = reader.get_entries().context("Failed to get entries")?;
        let entries = entries.iter().map(|entry| {
            let key = entry.get_key();
            let cost = entry.get_value();
            (key, cost)
        });
        let bigram_cost = entries.collect();

        Ok(CompactModel { bigram_cost })
    }

    pub fn save<W: Write>(&self, writer: W) -> Result<()> {
        let mut writer = Encoder::new(writer, 22).context("Failed to initialize encoder")?;

        let mut msg = Builder::new_default();
        let entries = msg.init_root::<compact_model::Builder>();
        let mut entries_list = entries.init_entries(self.bigram_cost.len() as u32);
        for (i, (key, cost)) in self.bigram_cost.iter().enumerate() {
            let mut entry = entries_list.reborrow().get(i as u32);
            entry.set_key(*key);
            entry.set_value(*cost);
        }
        serialize::write_message(&mut writer, &msg).context("Failed to write message")?;

        writer.finish().context("Failed to finish encoder")?;
        Ok(())
    }

    pub fn get_bigram_cost(&self, c1: char, c2: char) -> u8 {
        *self
            .bigram_cost
            .get(&((c1 as u64) << 32 | c2 as u64))
            .unwrap_or(&255)
    }

    pub(crate) fn set_bigram_cost(&mut self, key: u64, cost: u8) {
        self.bigram_cost.insert(key, cost);
    }
}
