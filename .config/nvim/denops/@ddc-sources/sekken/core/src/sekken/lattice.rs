use std::cell::RefCell;
use std::rc::Rc;

use anyhow::{Context, Result};

use crate::viterbi::Node;
use sekken_model::compact::CompactModel;

#[derive(Clone, Debug)]
pub struct Entry {
    head_han: char,
    tail_han: char,
    node: Rc<RefCell<Node<String>>>,
}

impl Entry {
    pub fn new(node: Rc<RefCell<Node<String>>>, head_han: char, tail_han: char) -> Entry {
        Entry {
            head_han,
            tail_han,
            node,
        }
    }
}

#[derive(Clone, Debug)]
pub struct Lattice {
    pub entries: Vec<Vec<Entry>>,
}

impl Lattice {
    pub fn new() -> Lattice {
        Lattice {
            entries: Vec::new(),
        }
    }

    pub fn push(&mut self, entries: Vec<Entry>) {
        self.entries.push(entries);
    }

    pub fn viterbi(&self, model: CompactModel, top_n: usize) -> Result<Vec<(u16, String)>> {
        if self.entries.is_empty() {
            return Ok(Vec::new());
        }

        let mut entries = self.entries.clone();
        let last = Node::new(String::new(), 0);
        entries.push(vec![Entry::new(last.clone(), '\0', '\0')]);

        let mut left = entries.first().context("entries is empty")?;
        for right in entries.iter().skip(1) {
            for left_entry in left {
                for right_entry in right {
                    let score = model.get_bigram_cost(left_entry.tail_han, right_entry.head_han);
                    let right_node = right_entry.node.clone();
                    right_node
                        .borrow_mut()
                        .add_left(left_entry.node.clone(), score);
                }
            }

            left = right;
        }

        let result = last
            .borrow()
            .clone()
            .calculate(top_n)
            .context("failed to calculate viterbi")?;

        Ok(result
            .iter()
            .map(|(score, path)| (*score, path.join("")))
            .collect())
    }
}
