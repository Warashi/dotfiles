import { Denops } from "https://deno.land/x/lspoints@v0.0.3/deps/denops.ts";
import {
  BaseExtension,
  Lspoints,
} from "https://deno.land/x/lspoints@v0.0.3/interface.ts";

export class Extension extends BaseExtension {
  override initialize(_denops: Denops, lspoints: Lspoints) {
    lspoints.settings.patch({
      startOptions: {
        denols: {
          cmd: ["deno", "lsp"],
          initializationOptions: {
            enable: true,
            unstable: true,
            suggest: {
              autoImports: false,
            },
          },
        },
        luals: {
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
        },
      },
    });
  }
}
