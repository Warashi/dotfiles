import { BaseConfig } from "https://deno.land/x/dpp_vim@v0.0.3/types.ts";
import type {
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.3/types.ts";
import type { Denops } from "https://deno.land/x/dpp_vim@v0.0.3/deps.ts";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<{
    plugins: Plugin[];
    stateLines: string[];
  }> {
    const inlineVimrcs = [
      "$DPP_CONFIG_BASE/disable-builtins.rc.vim",
      "$DPP_CONFIG_BASE/options.rc.vim",
      "$DPP_CONFIG_BASE/mappings.rc.vim",
      "$DPP_CONFIG_BASE/signs.rc.vim",
    ];

    args.contextBuilder.setGlobal({
      inlineVimrcs,
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    const loadToml = async (path: string, lazy: boolean): Promise<Plugin[]> =>
      await args.dpp.extAction(
        args.denops,
        context,
        options,
        "toml",
        "load",
        {
          path,
          options: {
            lazy,
          },
        },
      ) as Plugin[];

    const loadTomls = async (
      configs: { path: string; lazy: boolean }[],
    ): Promise<Plugin[]> => {
      let plugins = [] as Plugin[];
      for (const config of configs) {
        console.log(config.path);
        plugins = plugins.concat(await loadToml(config.path, config.lazy));
      }
      return plugins;
    };

    const plugins = await loadTomls([
      { path: "$DPP_CONFIG_BASE/someone.toml", lazy: false },
      // {path: "$DPP_CONFIG_BASE/ft.toml", lazy: false},

      { path: "$DPP_CONFIG_BASE/dpp.toml", lazy: false },

      { path: "$DPP_CONFIG_BASE/libs.toml", lazy: false },
      { path: "$DPP_CONFIG_BASE/libs-lazy.toml", lazy: true },

      { path: "$DPP_CONFIG_BASE/ui.toml", lazy: false },
      { path: "$DPP_CONFIG_BASE/ui-lazy.toml", lazy: true },

      { path: "$DPP_CONFIG_BASE/ddc.toml", lazy: true },
      { path: "$DPP_CONFIG_BASE/ddu.toml", lazy: true },

      { path: "$DPP_CONFIG_BASE/lsp.toml", lazy: true },
      { path: "$DPP_CONFIG_BASE/snippets.toml", lazy: true },
      { path: "$DPP_CONFIG_BASE/treesitter.toml", lazy: true },
    ]);

    const stateLines = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: plugins,
      },
    ) as string[];

    return { plugins, stateLines };
  }
}
