use std::cell::RefCell;
use std::cmp::{Eq, Ord};
use std::collections::BTreeMap;
use std::option::Option;
use std::rc::Rc;

use anyhow::{Context, Result};

#[derive(Clone, Debug)]
pub struct Node<T>
where
    T: Clone + Eq + Ord,
{
    value: T,

    score: u8,
    left: Vec<Edge<T>>,

    result: Option<BTreeMap<(u16, u8), Vec<T>>>,
}

#[derive(Clone, Debug)]
pub struct Edge<T>
where
    T: Clone + Eq + Ord,
{
    score: u8,
    left: Rc<RefCell<Node<T>>>,
}

impl<T> Node<T>
where
    T: Clone + Eq + Ord,
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

    pub fn calculate(&mut self, top_n: usize) -> Result<BTreeMap<(u16, u8), Vec<T>>> {
        if self.result.is_some() {
            return self.result.clone().context("result");
        }

        let mut result = BTreeMap::new();

        if self.left.is_empty() {
            let score = (self.score as u16, 0);
            result.insert(score, vec![self.value.clone()]);
            self.result = Some(result.clone());
            return Ok(result);
        }

        for edge in &self.left {
            let left_result = edge
                .left
                .borrow_mut()
                .calculate(top_n)
                .context("left result")?;

            for (score, values) in left_result {
                let score = score.0 + edge.score as u16 + self.score as u16;
                let mut values = values.clone();
                values.push(self.value.clone());

                match result.clone().iter().find(|(_, v)| v == &&values) {
                    Some((s, _)) if score <= s.0 => continue,
                    Some((s, _)) if score > s.0 => {
                        result.remove(s);
                    }
                    _ => {}
                }

                if result.len() < top_n {
                    let ord = result
                        .range((score, 0)..=(score, u8::MAX))
                        .map(|(k, _)| k.1)
                        .max()
                        .unwrap_or(0)
                        + 1;

                    result.insert((score, ord), values);
                } else {
                    let r2 = result.clone();
                    let max_score = r2.keys().max().context("max score")?;

                    if (score, u8::MAX) < *max_score {
                        result.remove(max_score);

                        let ord = result
                            .range((score, 0)..=(score, u8::MAX))
                            .map(|(k, _)| k.1)
                            .max()
                            .unwrap_or(0)
                            + 1;

                        result.insert((score, ord), values);
                    }
                }
            }
        }

        self.result = Some(result.clone());
        Ok(result)
    }
}
