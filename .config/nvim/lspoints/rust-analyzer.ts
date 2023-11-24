import type { Denops, StartOptions } from "./deps.ts";

// deno-lint-ignore require-await
export async function rust_analyzer(_denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["rust-analyzer"],
  };
}
