import type { Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";
import * as u from "https://deno.land/x/unknownutil@v3.11.0/mod.ts";
import * as rs from "./sekken-rs/wasm/pkg/sekken_wasm.js";
import * as path from "https://deno.land/std@0.171.0/path/mod.ts";

export function main(denops: Denops): void {
  rs.init();

  denops.dispatcher = {
    load_model: async () => {
      const __filename = new URL(import.meta.url).pathname;
      const model = await Deno.readFile(
        path.resolve(__filename, "../sekken-rs/model.bin.zst"),
      );
      rs.set_model(model);
    },
    set_dictionary: async (dictPath: unknown) => {
      const dict = await Deno.readTextFile(u.ensure(dictPath, u.isString));
      rs.set_skk_dictionary(JSON.parse(dict));
    },
    set_kana_table: (table: unknown) => {
      rs.set_kana_table(u.ensure(table, u.isRecordOf(u.isString)));
    },
    use_default_kana_table: () => {
      rs.use_default_kana_table();
    },
    get_default_kana_table: () => {
      console.error("get_default_kana_table is not implemented");
      return {};
    },
    henkan: (word: unknown, maxItems: unknown) => {
      return rs.henkan(
        u.ensure(word, u.isString),
        u.ensure(maxItems, u.isNumber),
      );
    },
  };
}
