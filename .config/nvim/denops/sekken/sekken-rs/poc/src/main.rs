use std::env;
use std::fs::File;
use std::path::Path;

use anyhow::{Context, Result};

use sekken_core::dictionary::SKKDictionary;
use sekken_core::kana::KanaTable;
use sekken_core::sekken::Sekken;
use sekken_model::compact::CompactModel;

fn main() -> Result<()> {
    let args: Vec<String> = env::args().collect();
    let dict = &args[1];
    let dict = Path::new(dict);
    let dict = File::open(dict).context("failed to open dictionary file")?;

    let dict: SKKDictionary =
        serde_json::from_reader(dict).context("failed to parse dictionary file")?;

    let model = &args[2];
    let model = Path::new(model);
    let model = File::open(model).context("failed to open model file")?;
    let model = CompactModel::load(model).context("failed to load model file")?;

    let sekken = Sekken::new();
    sekken.replace_kana_table(
        KanaTable::default_table().context("failed to load default kana table")?,
    );
    sekken.replace_dictionary(dict);
    sekken.replace_model(model);

    let result = sekken
        .viterbi_henkan(args[3].clone(), 10)
        .context("failed to henkan")?;

    println!("{:?}", result);

    Ok(())
}
