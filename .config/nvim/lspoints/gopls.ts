import type { Denops, StartOptions } from "./deps.ts";

// deno-lint-ignore require-await
export async function gopls(_denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["gopls"],
    initializationOptions: {
      buildFlags: ["-tags=wireinject"],
    },
  };
}
