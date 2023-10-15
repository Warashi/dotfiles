import { Denops } from "https://deno.land/x/lspoints@v0.0.4/deps/denops.ts";
import {
  BaseExtension,
  Lspoints,
  StartOptions,
} from "https://deno.land/x/lspoints@v0.0.4/interface.ts";
import { runtimepath } from "https://deno.land/x/denops_std@v5.0.1/option/mod.ts";

export class Extension extends BaseExtension {
  override async initialize(denops: Denops, lspoints: Lspoints) {
    const denols = {
      cmd: ["deno", "lsp"],
      initializationOptions: {
        enable: true,
        unstable: true,
        suggest: {
          autoImports: false,
        },
      },
    } as StartOptions;

    const luals = {
      cmd: ["lua-language-server"],
      params: {
        settings: {
          Lua: {
            runtime: {
              version: "LuaJIT",
            },
            diagnostics: {
              globals: ["vim"],
            },
            format: {
              enable: true,
            },
          },
        },
      },
    } as StartOptions;

    const gopls = {
      cmd: ["gopls"],
      initializationOptions: {
        buildFlags: ["-tags=wireinject"],
      },
    } as StartOptions;

    const nills = {
      cmd: ["nil"],
    } as StartOptions;

    const vimls = {
      cmd: ["vim-language-server", "--stdio"],
      initializationOptions: {
        isNeovim: true,
        isKeyword: "@,48-57,_,192-255,-#",
        vimruntime: Deno.env.get("VIMRUNTIME") ?? "",
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
    } as StartOptions;

    lspoints.settings.patch({
      startOptions: {
        denols: denols,
        luals: luals,
        gopls: gopls,
        nills: nills,
        vimls: vimls,
      },
    });
  }
}
