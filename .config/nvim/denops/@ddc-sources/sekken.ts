import {
  BaseSource,
  Context,
  Item,
} from "https://deno.land/x/ddc_vim@v4.1.0/types.ts";
import * as u from "https://deno.land/x/unknownutil@v3.10.0/mod.ts";

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
  return replaceDoubledConsonant(roman)
    .split(/((?=[\u3040-\u309F]+)|(?<=[\u3040-\u309F]+)|(?<=[aiueo]))/)
    .map((roman) => kanaTable[roman] ?? roman)
    .join("");
}

function replaceDoubledConsonant(roman: string): string {
  return roman
    .replace(/n(n|$)/g, "ん")
    .replace(/([bcdfghjklmpqrstvwxyz])\1/g, "っ$1")
    .replace(/n([bcdfghjklmpqrstvwxyz])/g, "ん$1");
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

const kanaTable: Record<string, string> = {
  "a": "あ",
  "ba": "ば",
  "be": "べ",
  "bi": "び",
  "bo": "ぼ",
  "bu": "ぶ",
  "bya": "びゃ",
  "bye": "びぇ",
  "byi": "びぃ",
  "byo": "びょ",
  "byu": "びゅ",
  "cha": "ちゃ",
  "che": "ちぇ",
  "chi": "ち",
  "cho": "ちょ",
  "chu": "ちゅ",
  "cya": "ちゃ",
  "cye": "ちぇ",
  "cyi": "ちぃ",
  "cyo": "ちょ",
  "cyu": "ちゅ",
  "da": "だ",
  "de": "で",
  "dha": "でゃ",
  "dhe": "でぇ",
  "dhi": "でぃ",
  "dho": "でょ",
  "dhu": "でゅ",
  "di": "ぢ",
  "do": "ど",
  "du": "づ",
  "dya": "ぢゃ",
  "dye": "ぢぇ",
  "dyi": "ぢぃ",
  "dyo": "ぢょ",
  "dyu": "ぢゅ",
  "e": "え",
  "fa": "ふぁ",
  "fe": "ふぇ",
  "fi": "ふぃ",
  "fo": "ふぉ",
  "fu": "ふ",
  "fya": "ふゃ",
  "fye": "ふぇ",
  "fyi": "ふぃ",
  "fyo": "ふょ",
  "fyu": "ふゅ",
  "ga": "が",
  "ge": "げ",
  "gi": "ぎ",
  "go": "ご",
  "gu": "ぐ",
  "gya": "ぎゃ",
  "gye": "ぎぇ",
  "gyi": "ぎぃ",
  "gyo": "ぎょ",
  "gyu": "ぎゅ",
  "ha": "は",
  "he": "へ",
  "hi": "ひ",
  "ho": "ほ",
  "hu": "ふ",
  "hya": "ひゃ",
  "hye": "ひぇ",
  "hyi": "ひぃ",
  "hyo": "ひょ",
  "hyu": "ひゅ",
  "i": "い",
  "ja": "じゃ",
  "je": "じぇ",
  "ji": "じ",
  "jo": "じょ",
  "ju": "じゅ",
  "jya": "じゃ",
  "jye": "じぇ",
  "jyi": "じぃ",
  "jyo": "じょ",
  "jyu": "じゅ",
  "ka": "か",
  "ke": "け",
  "ki": "き",
  "ko": "こ",
  "ku": "く",
  "kya": "きゃ",
  "kye": "きぇ",
  "kyi": "きぃ",
  "kyo": "きょ",
  "kyu": "きゅ",
  "ma": "ま",
  "me": "め",
  "mi": "み",
  "mo": "も",
  "mu": "む",
  "mya": "みゃ",
  "mye": "みぇ",
  "myi": "みぃ",
  "myo": "みょ",
  "myu": "みゅ",
  "na": "な",
  "ne": "ね",
  "ni": "に",
  "no": "の",
  "nu": "ぬ",
  "nya": "にゃ",
  "nye": "にぇ",
  "nyi": "にぃ",
  "nyo": "にょ",
  "nyu": "にゅ",
  "o": "お",
  "pa": "ぱ",
  "pe": "ぺ",
  "pi": "ぴ",
  "po": "ぽ",
  "pu": "ぷ",
  "pya": "ぴゃ",
  "pye": "ぴぇ",
  "pyi": "ぴぃ",
  "pyo": "ぴょ",
  "pyu": "ぴゅ",
  "ra": "ら",
  "re": "れ",
  "ri": "り",
  "ro": "ろ",
  "ru": "る",
  "rya": "りゃ",
  "rye": "りぇ",
  "ryi": "りぃ",
  "ryo": "りょ",
  "ryu": "りゅ",
  "sa": "さ",
  "se": "せ",
  "sha": "しゃ",
  "she": "しぇ",
  "shi": "し",
  "sho": "しょ",
  "shu": "しゅ",
  "si": "し",
  "so": "そ",
  "su": "す",
  "sya": "しゃ",
  "sye": "しぇ",
  "syi": "しぃ",
  "syo": "しょ",
  "syu": "しゅ",
  "ta": "た",
  "te": "て",
  "tha": "てぁ",
  "the": "てぇ",
  "thi": "てぃ",
  "tho": "てょ",
  "thu": "てゅ",
  "ti": "ち",
  "to": "と",
  "tsu": "つ",
  "tu": "つ",
  "tya": "ちゃ",
  "tye": "ちぇ",
  "tyi": "ちぃ",
  "tyo": "ちょ",
  "tyu": "ちゅ",
  "u": "う",
  "va": "ゔぁ",
  "ve": "ゔぇ",
  "vi": "ゔぃ",
  "vo": "ゔぉ",
  "vu": "ゔ",
  "wa": "わ",
  "we": "うぇ",
  "wi": "うぃ",
  "wo": "を",
  "wu": "う",
  "xa": "ぁ",
  "xe": "ぇ",
  "xi": "ぃ",
  "xka": "か",
  "xke": "け",
  "xo": "ぉ",
  "xtsu": "っ",
  "xtu": "っ",
  "xu": "ぅ",
  "xwa": "ゎ",
  "xwe": "ゑ",
  "xwi": "ゐ",
  "xya": "ゃ",
  "xyo": "ょ",
  "xyu": "ゅ",
  "ya": "や",
  "ye": "いぇ",
  "yo": "よ",
  "yu": "ゆ",
  "z(": "（",
  "z)": "）",
  "z:": "‥",
  "z-": "～",
  "z.": "…",
  "z/": "・",
  "z[": "『",
  "z\x20": "\u3000",
  "z]": "』",
  "za": "ざ",
  "ze": "ぜ",
  "zh": "←",
  "zi": "じ",
  "zj": "↓",
  "zk": "↑",
  "zl": "→",
  "zo": "ぞ",
  "zu": "ず",
  "zya": "じゃ",
  "zye": "じぇ",
  "zyi": "じぃ",
  "zyo": "じょ",
  "zyu": "じゅ",
} as const;
