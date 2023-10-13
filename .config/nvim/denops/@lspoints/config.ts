import { Denops } from "https://deno.land/x/lspoints@v0.0.3/deps/denops.ts";
import {
  BaseExtension,
  Lspoints,
  StartOptions,
} from "https://deno.land/x/lspoints@v0.0.3/interface.ts";

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

export class Extension extends BaseExtension {
  override initialize(_denops: Denops, lspoints: Lspoints) {
    lspoints.settings.patch({
      startOptions: {
        denols: denols,
        luals: luals,
        gopls: gopls,
        nills: nills,
      },
    });
  }
}
