import { Denops } from "https://deno.land/x/lspoints@v0.0.4/deps/denops.ts";
import {
  BaseExtension,
  Lspoints,
  StartOptions,
} from "https://deno.land/x/lspoints@v0.0.4/interface.ts";
import { runtimepath } from "https://deno.land/x/denops_std@v5.0.1/option/mod.ts";
import { nvim_get_runtime_file } from "https://deno.land/x/denops_std@v5.0.1/function/nvim/mod.ts";
import { environment } from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";

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
    } as StartOptions;

    const taplo = {
      cmd: ["taplo", "lsp", "stdio"],
    } as StartOptions;

    const efmls_cspell = {
      prefix: "cspell",
      lintCommand: "cspell lint --no-progress --no-summary --no-color ${INPUT}",
      lintFormats: [
        "%f:%l:%c - %m",
        "%f:%l:%c: %m",
      ],
      rootMakers: [
        "package.json",
        ".cspell.json",
        "cspell.json",
        ".cSpell.json",
        "cSpell.json",
        "cspell.config.js",
        "cspell.config.cjs",
        "cspell.config.json",
        "cspell.config.yaml",
        "cspell.config.yml",
        "cspell.yaml",
        "cspell.yml",
      ],
    } as const;

    const efmls = {
      cmd: ["efm-langserver"],
      settings: {
        rootMarkers: [".git/"],
        languages: {
          "=": [
            efmls_cspell,
          ],
        },
      },
    } as StartOptions;

    lspoints.settings.patch({
      startOptions: {
        denols,
        luals,
        gopls,
        nills,
        vimls,
        taplo,
        efmls,
      },
    });
  }
}
