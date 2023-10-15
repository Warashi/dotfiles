import { model as jaModel } from "npm:budoux@0.5.2/dist/data/models/ja.js";
import { Parser } from "npm:budoux@0.5.2/dist/parser.js";
import * as u from "https://deno.land/x/unknownutil@v3.9.0/mod.ts";
import type { Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";

export function main(denops: Denops): void {
  const parser = new Parser(jaModel);
  denops.dispatcher = {
    parse(text: unknown): string[] {
      u.assert(text, u.isString);
      return parser.parse(text);
    },
  };
}
