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
    // 全角変換は常に候補に入れる
    const zenkaku = args.completeStr.replace(
      /[!-~]/g,
      (c) => String.fromCharCode(c.charCodeAt(0) + 0xFEE0),
    );

    // 大文字から先は送り仮名として扱う
    const idx = args.completeStr.search(/[A-Z]/);
    if (idx !== -1) {
      const hiragana = roman2kana(args.completeStr.slice(0, idx));
      const okuri = args.completeStr.slice(idx).toLowerCase();
      return [
        { word: zenkaku },
        ...okuri_ari(hiragana, okuri).map((word) => ({ word })),
      ];
    }

    // 送り仮名なしの場合のみひらがなとカタカナの候補を入れる
    const hiragana = roman2kana(args.completeStr);
    const katakana = hiragana.replace(
      /[\u3040-\u309F]/g,
      (c) => String.fromCharCode(c.charCodeAt(0) + 96),
    );
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

function okuri_ari(hira: string, okuri: string): string[] {
  const alpha = okuri[0];
  const entries = jisyo.okuri_ari[hira + alpha];
  if (!entries) {
    return [];
  }
  return entries.map((word) => word + roman2kana(okuri));
}

