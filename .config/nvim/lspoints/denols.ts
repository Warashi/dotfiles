import type { Denops, StartOptions } from "./deps.ts";

// deno-lint-ignore require-await
export async function denols(_denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["deno", "lsp"],
    initializationOptions: {
      enable: true,
      unstable: true,
      suggest: {
        autoImports: false,
      },
    },
  };
}
