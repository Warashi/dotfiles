mod table;

pub fn roman2kana(roman: String) -> String {
    let mut it = table::kana_table()
        .leftmost_find_iter(roman.clone())
        .collect::<Vec<_>>();
    it.reverse();

    let mut kana = roman.clone();
    for m in it {
        kana.replace_range(m.start()..m.end(), m.value());
    }
    kana
}
