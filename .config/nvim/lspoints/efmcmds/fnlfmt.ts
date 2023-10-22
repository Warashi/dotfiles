import type { Denops } from "../deps.ts";
import type { ToolDefinition } from "./types.ts";

// deno-lint-ignore require-await
export async function fnlfmt(_denops: Denops): Promise<ToolDefinition> {
  return {
    prefix: "fnlfmt",
    formatCommand: "fnlfmt ${INPUT}",
  };
}
