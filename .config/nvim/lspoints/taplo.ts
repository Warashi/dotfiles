import type { Denops, StartOptions } from "./deps.ts";

// deno-lint-ignore require-await
export async function taplo(_denops: Denops): Promise<StartOptions> {
  return {
      cmd: ["taplo", "lsp", "stdio"],
  };
}
