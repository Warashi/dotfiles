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
    return henkan(args.completeStr).map((word) => ({ word }));
  }

  override params(): Params {
    return {};
  }
}

function henkan(roman: string): string[] {
  // 全角変換は常に候補に入れる
  const zenkaku = roman.replace(
    /[!-~]/g,
    (c) => String.fromCharCode(c.charCodeAt(0) + 0xFEE0),
  );

  const idx = roman.search(/[A-Z]/);
  switch (idx) {
    case -1: {
      // 漢字の候補を入れない
      return [
        ...kanaHenkan(roman),
        zenkaku,
      ];
    }
    case 0: {
      // 漢字の候補を入れる
      return [
        ...kanjiHenkan(roman),
        zenkaku,
      ];
    }
    default: {
      // 最初の大文字まではひらがなに変換してから漢字の候補を入れる
      const hiragana = roman2kana(roman.slice(0, idx));
      return [
        ...kanjiHenkan(roman.slice(idx)).map((word) => hiragana + word),
        zenkaku,
      ];
    }
  }
}

function kanaHenkan(roman: string): string[] {
  const hiragana = roman2kana(roman);
  const katakana = hiragana.replace(
    /[\u3040-\u309F]/g,
    (c) => String.fromCharCode(c.charCodeAt(0) + 96),
  );
  return [
    hiragana,
    katakana,
    ...okuri_nasi(roman),
  ];
}

function kanjiHenkan(roman: string): string[] {
  const from = roman[0].toLowerCase() + roman.slice(1);
  const idx = from.search(/[A-Z]/);
  switch (idx) {
    case -1: {
      // 送り仮名なし
      return [
        ...okuri_nasi(roman2kana(from)),
        ...okuri_nasi(roman),
      ];
    }
    default: {
      // 送り仮名あり
      const hiragana = roman2kana(from.slice(0, idx));
      const okuri = from.slice(idx).toLowerCase();
      return okuri_ari(hiragana, okuri);
    }
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
