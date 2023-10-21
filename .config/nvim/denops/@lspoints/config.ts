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
      cmd: ["efm-langserver"],
      settings: {
        rootMarkers: [".git/"],
        languages: {
          "=": [
            await config.efmcmds.cspell(denops),
          ],
        },
      },
    } as StartOptions;

    lspoints.settings.patch({
      startOptions: {
        denols: await config.denols(denops),
        luals: await config.luals(denops),
        gopls: await config.gopls(denops),
        nills: await config.nills(denops),
        vimls: await config.vimls(denops),
        taplo: await config.taplo(denops),
        efmls,
      },
    });
  }
}
