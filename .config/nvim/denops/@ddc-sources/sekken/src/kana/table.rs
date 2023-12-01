use daachorse::{DoubleArrayAhoCorasick, DoubleArrayAhoCorasickBuilder, MatchKind};

pub fn gen_kana_table() -> DoubleArrayAhoCorasick<&'static str> {
    return DoubleArrayAhoCorasickBuilder::new()
        .match_kind(MatchKind::LeftmostLongest)
        .build_with_values(vec![
            ("!", "！"),
            (",", "、"),
            ("-", "ー"),
            (".", "。"),
            (":", "："),
            ("?", "？"),
            ("[", "「"),
            ("]", "」"),
            ("a", "あ"),
            ("ba", "ば"),
            ("b", "っ"),
            ("be", "べ"),
            ("bi", "び"),
            ("bo", "ぼ"),
            ("bu", "ぶ"),
            ("bya", "びゃ"),
            ("bye", "びぇ"),
            ("byi", "びぃ"),
            ("byo", "びょ"),
            ("byu", "びゅ"),
            ("c", "っ"),
            ("cha", "ちゃ"),
            ("che", "ちぇ"),
            ("chi", "ち"),
            ("cho", "ちょ"),
            ("chu", "ちゅ"),
            ("cya", "ちゃ"),
            ("cye", "ちぇ"),
            ("cyi", "ちぃ"),
            ("cyo", "ちょ"),
            ("cyu", "ちゅ"),
            ("da", "だ"),
            ("d", "っ"),
            ("de", "で"),
            ("dha", "でゃ"),
            ("dhe", "でぇ"),
            ("dhi", "でぃ"),
            ("dho", "でょ"),
            ("dhu", "でゅ"),
            ("di", "ぢ"),
            ("do", "ど"),
            ("du", "づ"),
            ("dya", "ぢゃ"),
            ("dye", "ぢぇ"),
            ("dyi", "ぢぃ"),
            ("dyo", "ぢょ"),
            ("dyu", "ぢゅ"),
            ("e", "え"),
            ("fa", "ふぁ"),
            ("fe", "ふぇ"),
            ("f", "っ"),
            ("fi", "ふぃ"),
            ("fo", "ふぉ"),
            ("fu", "ふ"),
            ("fya", "ふゃ"),
            ("fye", "ふぇ"),
            ("fyi", "ふぃ"),
            ("fyo", "ふょ"),
            ("fyu", "ふゅ"),
            ("ga", "が"),
            ("ge", "げ"),
            ("g", "っ"),
            ("gi", "ぎ"),
            ("go", "ご"),
            ("gu", "ぐ"),
            ("gya", "ぎゃ"),
            ("gye", "ぎぇ"),
            ("gyi", "ぎぃ"),
            ("gyo", "ぎょ"),
            ("gyu", "ぎゅ"),
            ("ha", "は"),
            ("he", "へ"),
            ("h", "っ"),
            ("hi", "ひ"),
            ("ho", "ほ"),
            ("hu", "ふ"),
            ("hya", "ひゃ"),
            ("hye", "ひぇ"),
            ("hyi", "ひぃ"),
            ("hyo", "ひょ"),
            ("hyu", "ひゅ"),
            ("i", "い"),
            ("ja", "じゃ"),
            ("je", "じぇ"),
            ("ji", "じ"),
            ("j", "っ"),
            ("jo", "じょ"),
            ("ju", "じゅ"),
            ("jya", "じゃ"),
            ("jye", "じぇ"),
            ("jyi", "じぃ"),
            ("jyo", "じょ"),
            ("jyu", "じゅ"),
            ("ka", "か"),
            ("ke", "け"),
            ("ki", "き"),
            ("k", "っ"),
            ("ko", "こ"),
            ("ku", "く"),
            ("kya", "きゃ"),
            ("kye", "きぇ"),
            ("kyi", "きぃ"),
            ("kyo", "きょ"),
            ("kyu", "きゅ"),
            ("ma", "ま"),
            ("me", "め"),
            ("mi", "み"),
            ("m", "っ"),
            ("mo", "も"),
            ("mu", "む"),
            ("mya", "みゃ"),
            ("mye", "みぇ"),
            ("myi", "みぃ"),
            ("myo", "みょ"),
            ("myu", "みゅ"),
            ("n", "ん"),
            ("n'", "ん"),
            ("na", "な"),
            ("ne", "ね"),
            ("ni", "に"),
            ("nn", "ん"),
            ("no", "の"),
            ("nu", "ぬ"),
            ("nya", "にゃ"),
            ("nye", "にぇ"),
            ("nyi", "にぃ"),
            ("nyo", "にょ"),
            ("nyu", "にゅ"),
            ("o", "お"),
            ("pa", "ぱ"),
            ("pe", "ぺ"),
            ("pi", "ぴ"),
            ("po", "ぽ"),
            ("p", "っ"),
            ("pu", "ぷ"),
            ("pya", "ぴゃ"),
            ("pye", "ぴぇ"),
            ("pyi", "ぴぃ"),
            ("pyo", "ぴょ"),
            ("pyu", "ぴゅ"),
            ("ra", "ら"),
            ("re", "れ"),
            ("ri", "り"),
            ("ro", "ろ"),
            ("r", "っ"),
            ("ru", "る"),
            ("rya", "りゃ"),
            ("rye", "りぇ"),
            ("ryi", "りぃ"),
            ("ryo", "りょ"),
            ("ryu", "りゅ"),
            ("sa", "さ"),
            ("se", "せ"),
            ("sha", "しゃ"),
            ("she", "しぇ"),
            ("shi", "し"),
            ("sho", "しょ"),
            ("shu", "しゅ"),
            ("si", "し"),
            ("so", "そ"),
            ("s", "っ"),
            ("su", "す"),
            ("sya", "しゃ"),
            ("sye", "しぇ"),
            ("syi", "しぃ"),
            ("syo", "しょ"),
            ("syu", "しゅ"),
            ("ta", "た"),
            ("te", "て"),
            ("tha", "てぁ"),
            ("the", "てぇ"),
            ("thi", "てぃ"),
            ("tho", "てょ"),
            ("thu", "てゅ"),
            ("ti", "ち"),
            ("to", "と"),
            ("tsu", "つ"),
            ("t", "っ"),
            ("tu", "つ"),
            ("tya", "ちゃ"),
            ("tye", "ちぇ"),
            ("tyi", "ちぃ"),
            ("tyo", "ちょ"),
            ("tyu", "ちゅ"),
            ("u", "う"),
            ("va", "ゔぁ"),
            ("ve", "ゔぇ"),
            ("vi", "ゔぃ"),
            ("vo", "ゔぉ"),
            ("vu", "ゔ"),
            ("v", "っ"),
            ("wa", "わ"),
            ("we", "うぇ"),
            ("wi", "うぃ"),
            ("wo", "を"),
            ("wu", "う"),
            ("w", "っ"),
            ("xa", "ぁ"),
            ("xe", "ぇ"),
            ("xi", "ぃ"),
            ("xka", "か"),
            ("xke", "け"),
            ("xo", "ぉ"),
            ("xtsu", "っ"),
            ("xtu", "っ"),
            ("xu", "ぅ"),
            ("xwa", "ゎ"),
            ("xwe", "ゑ"),
            ("xwi", "ゐ"),
            ("x", "っ"),
            ("xya", "ゃ"),
            ("xyo", "ょ"),
            ("xyu", "ゅ"),
            ("ya", "や"),
            ("ye", "いぇ"),
            ("yo", "よ"),
            ("yu", "ゆ"),
            ("y", "っ"),
            ("z(", "（"),
            ("z)", "）"),
            ("z,", "‥"),
            ("z-", "～"),
            ("z.", "…"),
            ("z/", "・"),
            ("z[", "『"),
            ("z\x20", "\u{3000}"), // z<Space>で全角スペース
            ("z]", "』"),
            ("za", "ざ"),
            ("ze", "ぜ"),
            ("zh", "←"),
            ("zi", "じ"),
            ("zj", "↓"),
            ("zk", "↑"),
            ("zl", "→"),
            ("zo", "ぞ"),
            ("zu", "ず"),
            ("zya", "じゃ"),
            ("zye", "じぇ"),
            ("zyi", "じぃ"),
            ("zyo", "じょ"),
            ("zyu", "じゅ"),
            ("z", "っ"),
        ])
        .unwrap();
}
