import type { Denops, StartOptions } from "./deps.ts";
import { nvim_list_runtime_paths } from "./deps.ts";

export async function fennells(denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["fennel-language-server"],
    params: {
      settings: {
        fennel: {
          workspace: {
            library: await nvim_list_runtime_paths(denops),
          },
          diagnostics: {
            globals: ["vim"],
          },
        },
      },
    },
  };
}
