import {
  BaseSource,
  Context,
  Item,
} from "https://deno.land/x/ddc_vim@v4.1.0/types.ts";
import * as u from "https://deno.land/x/unknownutil@v3.10.0/mod.ts";
import * as rs from "./sekken/pkg/sekken.js";
rs.init();

const jisyo = u.ensure(
  JSON.parse(
    Deno.readTextFileSync(
      Deno.env.get("HOME") + "/.config/sekken/jisyo/SKK-JISYO.L.json",
    ),
  ),
  u.isObjectOf({
    okuri_ari: u.isRecordOf(u.isArrayOf(u.isString)),
    okuri_nasi: u.isRecordOf(u.isArrayOf(u.isString)),
  }),
);

export type Params = Record<string | never | symbol, never>;

export class Source extends BaseSource<Params> {
  // deno-lint-ignore require-await
  override async gather(args: {
    context: Context;
    completeStr: string;
  }): Promise<Item[]> {
    const zenkaku = args.completeStr.replace(
      /[!-~]/g,
      (c) => String.fromCharCode(c.charCodeAt(0) + 0xFEE0),
    );
    const hiragana = roman2kana(args.completeStr);
    const katakana = hiragana.replace(
      /[\u3040-\u309F]/g,
      (c) => String.fromCharCode(c.charCodeAt(0) + 96),
    );
    if (args.completeStr.match(/[A-Z]/)) {
      return [
        { word: zenkaku },
        ...okuri_ari(hiragana).map((word) => ({ word })),
      ];
    }
    return [
      { word: hiragana },
      { word: katakana },
      { word: zenkaku },
      ...okuri_nasi(hiragana).map((word) => ({ word })),
    ];
  }

  override params(): Params {
    return {};
  }
}

// ローマ字からひらがなに変換する
function roman2kana(roman: string): string {
  return rs.roman2kana(roman);
}

function okuri_nasi(from: string): string[] {
  return jisyo.okuri_nasi[from] ?? [];
}

function okuri_ari(from: string): string[] {
  const [left, right] = from.split(/(?<=[A-Z])/);
  const [hira, alpha] = [left.slice(0, -1), left.slice(-1).toLowerCase()];
  const entries = jisyo.okuri_ari[hira + alpha];
  if (!entries) {
    return [];
  }
  return entries.map((word) => word + roman2kana(alpha + (right ?? "")));
}
