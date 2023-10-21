import type { Denops, StartOptions } from "./deps.ts";
import { nvim_get_runtime_file } from "./deps.ts";

export async function luals(denops: Denops): Promise<StartOptions> {
  return {
    cmd: ["lua-language-server"],
    params: {
      settings: {
        Lua: {
          runtime: {
            version: "LuaJIT",
          },
          format: {
            enable: true,
          },
          workspace: {
            library: await nvim_get_runtime_file(denops, "", true),
            checkThirdParty: false,
          },
        },
      },
    },
  };
}
