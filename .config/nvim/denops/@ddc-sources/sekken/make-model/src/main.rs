use std::io::{BufWriter, Write};

use bzip2::read::MultiBzDecoder;

use sekken_model::NormalModel;

fn main() {
    let input = std::io::stdin();
    let input = std::io::BufReader::new(input);
    let input = MultiBzDecoder::new(input);
    let mut input = utf8_read::Reader::new(input);
    let mut pre: Option<char> = None;

    let mut model = NormalModel::new();

    for ch in input.into_iter() {
        if let Ok(c) = ch {
            if !is_han(c) {
                continue;
            }

            model.increment_unigram_cost(c);

            if let Some(p) = pre {
                model.increment_bigram_cost(p, c);
            }

            pre = Some(c);
        }
    }
    let model = model;

    let output = std::io::stdout();
    let mut output = BufWriter::new(output);

    model.compact().save(&mut output).unwrap();
    output.flush().unwrap();
}

fn is_han(ch: char) -> bool {
    let code = ch as u32;
    match code {
        0x4E00..=0x9FFF => true,
        0x3400..=0x4DBF => true,
        0x20000..=0x2A6DF => true,
        0x2A700..=0x2B73F => true,
        0x2B740..=0x2B81F => true,
        0x2B820..=0x2CEAF => true,
        0xF900..=0xFAFF => true,
        0x2F800..=0x2FA1F => true,
        _ => false,
    }
}
