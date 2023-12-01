mod table;

use daachorse::DoubleArrayAhoCorasick;
use std::sync::OnceLock;

static KANA_TABLE: OnceLock<DoubleArrayAhoCorasick<&str>> = OnceLock::new();

fn kana_table() -> DoubleArrayAhoCorasick<&'static str> {
    KANA_TABLE
        .get_or_init(|| table::gen_kana_table())
        .to_owned()
}

pub fn roman2kana(roman: String) -> String {
    let mut it = kana_table()
        .leftmost_find_iter(roman.clone())
        .collect::<Vec<_>>();
    it.reverse();

    let mut kana = roman.clone();
    for m in it {
        kana.replace_range(m.start()..m.end(), m.value());
    }
    kana
}
