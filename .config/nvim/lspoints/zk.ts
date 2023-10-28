import type { Denops, StartOptions } from "./deps.ts";

// deno-lint-ignore require-await
export async function zk(_denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["zk", "lsp"],
  };
}
