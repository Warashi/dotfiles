import type { Denops, StartOptions } from "./deps.ts";
import { nvim_get_runtime_file } from "./deps.ts";

export async function fennells(denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["fennel-language-server"],
    params: {
      settings: {
        fennel: {
          workspace: {
            library: await nvim_get_runtime_file(denops, "", true),
          },
          diagnostics: {
            globals: ["vim"],
          },
        },
      },
    },
  };
}
