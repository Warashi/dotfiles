import type { Denops, StartOptions } from "./deps.ts";

// deno-lint-ignore require-await
export async function nixd(_denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["nixd"],
  };
}
