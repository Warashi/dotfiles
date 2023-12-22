import {
  BaseSource,
  Context,
  Item,
  SourceOptions,
} from "https://deno.land/x/ddc_vim@v4.1.0/types.ts";
import * as rs from "./sekken/wasm/pkg/sekken_wasm.js";
rs.init();
rs.use_default_kana_table();

rs.set_skk_dictionary(JSON.parse(
  Deno.readTextFileSync(
    Deno.env.get("HOME") + "/.config/sekken/jisyo/SKK-JISYO.L.json",
  ),
));

rs.set_model(
  Deno.readFileSync(Deno.env.get("HOME") + "/.config/sekken/model.bin"),
);

export type Params = Record<string | number | symbol, never>;

export class Source extends BaseSource<Params> {
  // deno-lint-ignore require-await
  override async gather(args: {
    context: Context;
    completeStr: string;
    sourceOptions: SourceOptions;
  }): Promise<Item[]> {
    return henkan(args.completeStr, args.sourceOptions.maxItems).map((
      word,
    ) => ({ word }));
  }

  override params(): Params {
    return {};
  }
}

function henkan(roman: string, n: number): string[] {
  return rs.viterbi_henkan(roman, n);
}
