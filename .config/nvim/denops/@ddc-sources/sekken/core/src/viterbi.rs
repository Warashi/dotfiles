use std::cell::RefCell;
use std::collections::BTreeMap;
use std::option::Option;
use std::rc::Rc;

use anyhow::{Context, Result};

#[derive(Clone, Debug)]
pub struct Node<T>
where
    T: Clone,
{
    value: T,

    score: u8,
    left: Vec<Edge<T>>,

    result: Option<BTreeMap<u16, Vec<T>>>,
}

#[derive(Clone, Debug)]
pub struct Edge<T>
where
    T: Clone,
{
    score: u8,
    left: Rc<RefCell<Node<T>>>,
}

impl<T> Node<T>
where
    T: Clone,
{
    pub fn new(value: T, score: u8) -> Rc<RefCell<Self>> {
        Rc::new(RefCell::new(Self::new_node(value, score)))
    }

    fn new_node(value: T, score: u8) -> Self {
        Self {
            value,
            score,
            left: Vec::new(),
            result: None,
        }
    }

    pub fn add_left(&mut self, left: Rc<RefCell<Self>>, score: u8) {
        self.left.push(Edge { score, left });
    }

    pub fn calculate(&mut self, top_n: usize) -> Result<BTreeMap<u16, Vec<T>>> {
        if self.result.is_some() {
            return self.clone().result.context("result");
        }

        let mut result = BTreeMap::new();

        for edge in &self.left {
            let left_result = edge
                .left
                .borrow_mut()
                .calculate(top_n)
                .context("left result")?;

            for (score, values) in left_result {
                let score = score + edge.score as u16 + self.score as u16;
                let mut values = values.clone();
                values.push(self.value.clone());

                if result.len() < top_n {
                    result.insert(score, values);
                } else {
                    let r2 = result.clone();
                    let max_score = r2.keys().max().context("min score")?;

                    if score > *max_score {
                        result.remove(&max_score);
                        result.insert(score, values);
                    }
                }
            }
        }

        self.result = Some(result.clone());
        Ok(result)
    }
}
