import type { Denops } from "../deps.ts";
import type { ToolDefinition } from "./types.ts";

// deno-lint-ignore require-await
export async function alejandra(_denops: Denops): Promise<ToolDefinition> {
  return {
    prefix: "alejandra",
    formatCommand: "alejandra --quiet -",
    formatStdin: true,
  };
}
