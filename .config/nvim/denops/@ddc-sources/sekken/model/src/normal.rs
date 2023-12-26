use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use crate::compact::CompactModel;

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct NormalModel {
    bigram_cost: HashMap<u64, u128>,
}

impl Default for NormalModel {
    fn default() -> Self {
        Self::new()
    }
}

impl NormalModel {
    pub fn new() -> Self {
        Self {
            bigram_cost: HashMap::new(),
        }
    }

    pub fn increment_bigram_cost(&mut self, c1: char, c2: char) {
        self.bigram_cost
            .entry((c1 as u64) << 32 | c2 as u64)
            .and_modify(|e| *e += 1)
            .or_insert(1);
    }

    pub fn compact(&self) -> CompactModel {
        let mut compact = CompactModel::new();

        for (key, cost) in self.bigram_cost.iter() {
            let cost = (1 + cost).ilog2() as u8;
            compact.set_bigram_cost(*key, 255 - cost);
        }

        compact
    }
}
