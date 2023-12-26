import * as u from "https://deno.land/x/unknownutil@v3.11.0/mod.ts";
import type { Denops } from "https://deno.land/x/ddc_vim@v4.1.0/deps.ts";
import {
  BaseSource,
  Context,
  Item,
  SourceOptions,
} from "https://deno.land/x/ddc_vim@v4.1.0/types.ts";
export type Params = Record<string | number | symbol, never>;

export class Source extends BaseSource<Params> {
  override async gather(args: {
    denops: Denops;
    context: Context;
    completeStr: string;
    sourceOptions: SourceOptions;
  }): Promise<Item[]> {
    const words = await args.denops.dispatch(
      "sekken",
      "henkan",
      args.completeStr,
      args.sourceOptions.maxItems,
    );
    u.assert(words, u.isArrayOf(u.isString));
    return words.map((word) => ({ word }));
  }

  override params(): Params {
    return {};
  }
}
