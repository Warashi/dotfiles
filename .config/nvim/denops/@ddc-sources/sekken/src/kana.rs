mod table;

use daachorse::{DoubleArrayAhoCorasick, DoubleArrayAhoCorasickBuilder, MatchKind};

pub struct KanaTable<'a> {
    table: DoubleArrayAhoCorasick<&'a str>,
}

impl<'a> KanaTable<'a> {
    pub fn new<I>(patvals: I) -> Option<KanaTable<'a>>
    where
        I: IntoIterator<Item = (&'a str, &'a str)>,
    {
        let ac = DoubleArrayAhoCorasickBuilder::new()
            .match_kind(MatchKind::LeftmostLongest)
            .build_with_values(patvals)
            .ok()?;

        return Some(KanaTable { table: ac });
    }

    pub fn default() -> Option<KanaTable<'a>> {
        return KanaTable::new(table::default());
    }

    pub fn roman2kana(&self, roman: String) -> String {
        let mut it = self
            .table
            .leftmost_find_iter(roman.clone())
            .collect::<Vec<_>>();
        it.reverse();

        let mut kana = roman.clone();
        for m in it {
            kana.replace_range(m.start()..m.end(), m.value());
        }
        return kana;
    }
}
