import type { Denops } from "https://deno.land/x/lspoints@v0.0.4/deps/denops.ts";
import {
  BaseExtension,
  type Lspoints,
  type StartOptions,
} from "https://deno.land/x/lspoints@v0.0.4/interface.ts";

import * as config from "../../lspoints/mod.ts";

export class Extension extends BaseExtension {
  override async initialize(denops: Denops, lspoints: Lspoints) {
    const efmls = {
      cmd: ["efm-langserver", "-q"],
      initializationOptions: {
        documentFormatting: true,
      },
      params: {
        settings: {
          rootMarkers: [".git/"],
          languages: {
            "=": [
              await config.efmcmds.cspell(denops),
            ],
            "nix": [
              await config.efmcmds.alejandra(denops),
              await config.efmcmds.deadnix(denops),
              await config.efmcmds.statix(denops),
            ],
            "fennel": [
              await config.efmcmds.fnlfmt(denops),
            ],
          },
        },
      },
    } as StartOptions;

    lspoints.settings.patch({
      startOptions: {
        efmls,

        denols: await config.denols(denops),
        fennells: await config.fennells(denops),
        gopls: await config.gopls(denops),
        luals: await config.luals(denops),
        marksman: await config.marksman(denops),
        nixd: await config.nixd(denops),
        rust_analyzer: await config.rust_analyzer(denops),
        taplo: await config.taplo(denops),
        vimls: await config.vimls(denops),
        zk: await config.zk(denops),
      },
    });
  }
}
