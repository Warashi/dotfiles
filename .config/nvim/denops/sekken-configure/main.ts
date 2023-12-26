import type { Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";

export async function main(denops: Denops): Promise<void> {
  await Promise.all([
    denops.dispatch("sekken", "use_default_kana_table"),
    denops.dispatch(
      "sekken",
      "set_model",
      Deno.env.get("HOME") + "/.config/sekken/model.bin",
    ),
    denops.dispatch(
      "sekken",
      "set_dictionary",
      Deno.env.get("HOME") + "/.config/sekken/jisyo/SKK-JISYO.L.json",
    ),
  ]);
  console.log("load finished");
}
