import type { Denops } from "../deps.ts";
import type { ToolDefinition } from "./types.ts";

// deno-lint-ignore require-await
export async function cspell(_denops: Denops): Promise<ToolDefinition> {
  return {
    prefix: "cspell",
    lintCommand: "cspell lint --no-progress --no-summary --no-color ${INPUT}",
    lintFormats: [
      "%f:%l:%c - %m",
      "%f:%l:%c: %m",
    ],
    rootMakers: [
      "package.json",
      ".cspell.json",
      "cspell.json",
      ".cSpell.json",
      "cSpell.json",
      "cspell.config.js",
      "cspell.config.cjs",
      "cspell.config.json",
      "cspell.config.yaml",
      "cspell.config.yml",
      "cspell.yaml",
      "cspell.yml",
    ],
  };
}
