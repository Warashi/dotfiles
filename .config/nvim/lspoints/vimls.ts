import type { Denops, StartOptions } from "./deps.ts";
import { environment, runtimepath } from "./deps.ts";

export async function vimls(denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["vim-language-server", "--stdio"],
    initializationOptions: {
      isNeovim: true,
      isKeyword: "@,48-57,_,192-255,-#",
      vimruntime: await environment.get(denops, "VIMRUNTIME"),
      runtimepath: await runtimepath.get(denops),
      diagnostic: {
        enable: true,
      },
      indexes: {
        runtimepath: true,
        gap: 100,
        count: 3,
        projectRootPatterns: ["nvim", ".git"],
      },
      suggest: {
        fromVimruntime: true,
        fromRuntimepath: true,
      },
    },
  };
}
