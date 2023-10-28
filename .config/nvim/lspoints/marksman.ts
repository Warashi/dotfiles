import type { Denops, StartOptions } from "./deps.ts";

// deno-lint-ignore require-await
export async function marksman(_denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["marksman", "server"],
  };
}
