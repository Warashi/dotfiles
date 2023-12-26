mod table;

use daachorse::{DoubleArrayAhoCorasick, DoubleArrayAhoCorasickBuilder, MatchKind};

#[derive(Clone)]
pub struct KanaTable {
    table: DoubleArrayAhoCorasick<usize>,
    values: Vec<String>,
}

impl KanaTable {
    pub fn new<I>(patvals: I) -> Option<KanaTable>
    where
        I: IntoIterator<Item = (String, String)>,
    {
        let patvals = patvals.into_iter().collect::<Vec<_>>();
        let values = patvals
            .clone()
            .into_iter()
            .map(|(_, val)| val)
            .collect::<Vec<_>>();
        let table = patvals
            .clone()
            .into_iter()
            .enumerate()
            .map(|(i, (pat, _))| (pat, i))
            .collect::<Vec<_>>();
        let table = DoubleArrayAhoCorasickBuilder::new()
            .match_kind(MatchKind::LeftmostLongest)
            .build_with_values(table)
            .ok()?;

        Some(KanaTable { table, values })
    }

    pub fn default_table() -> Option<KanaTable> {
        KanaTable::new(table::default())
    }

    pub fn roman2kana(&self, roman: String) -> String {
        let mut it = self
            .table
            .leftmost_find_iter(roman.clone())
            .collect::<Vec<_>>();
        it.reverse();

        let mut kana = roman.clone();
        for m in it {
            kana.replace_range(m.start()..m.end(), self.values[m.value()].as_str());
        }
        kana
    }
}
