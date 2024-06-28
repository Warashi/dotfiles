import { BaseConfig } from "https://deno.land/x/dpp_vim@v0.3.0/types.ts";
import type {
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.3.0/types.ts";
import {
  convert2List,
  parseHooksFile,
} from "https://deno.land/x/dpp_vim@v0.3.0/utils.ts";
import type { Denops } from "https://deno.land/x/dpp_vim@v0.3.0/deps.ts";
import * as u from "https://deno.land/x/unknownutil@v3.18.1/mod.ts";

type Toml = {
  hooks_file?: string;
  ftplugins?: Record<string, string>;
  plugins: Plugin[];
};

type LazyMakeStateResult = {
  plugins: Plugin[];
  stateLines: string[];
};

async function fennelCompile(text: string): Promise<string> {
  const cmd = new Deno.Command("fennel", {
    args: ["--compile", "-"],
    stdin: "piped",
    stdout: "piped",
  });
  const child = cmd.spawn();

  (new Blob([text], { type: "text/plain" }).stream()).pipeTo(
    child.stdin,
  );

  return await new Response(child.stdout).text();
}

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

    const loadToml = async (path: string, lazy: boolean): Promise<Toml> =>
      await args.dpp.extAction(
        args.denops,
        context,
        options,
        "toml",
        "load",
        { path, options: { lazy, denops_wait: false } },
      ) as Toml;

    const loadTomls = async (
      configs: { path: string; lazy: boolean }[],
    ): Promise<Plugin[]> => {
      let plugins = [] as Plugin[];
      for (const config of configs) {
        plugins = plugins.concat(
          (await loadToml(config.path, config.lazy)).plugins,
        );
      }
      return plugins;
    };

    let plugins = await loadTomls([
      { path: "$DPP_CONFIG_BASE/someone.toml", lazy: false },

      { path: "$DPP_CONFIG_BASE/dpp.toml", lazy: true },

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

    plugins = await Promise.all(plugins.map(async (plugin) => {
      for (const hooksFile of convert2List(plugin.hooks_file)) {
        const hooksFilePath = await args.denops.call(
          "dpp#util#_expand",
          hooksFile,
        ) as string;
        const hooksFileLines = (await Deno.readTextFile(hooksFilePath)).split(
          "\n",
        );

        const hooks = parseHooksFile(options.hooksFileMarker, hooksFileLines);
        plugin = Object.assign(plugin, hooks);
      }
      plugin.hooks_file = undefined;
      return plugin;
    }));

    plugins = await Promise.all(plugins.map(async (plugin) => {
      if (!plugin.ftplugin) {
        return plugin;
      }
      if (u.isString(plugin.ftplugin.fennel_add)) {
        plugin.lua_add = await fennelCompile(plugin.ftplugin.fennel_add);
        delete plugin.ftplugin.fennel_add;
      }
      if (u.isString(plugin.ftplugin.fennel_source)) {
        plugin.lua_source = await fennelCompile(plugin.ftplugin.fennel_source);
        delete plugin.ftplugin.fennel_source;
      }
      return plugin;
    }));

    const lazyResult = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      { plugins },
    ) as LazyMakeStateResult;

    return {
      ...lazyResult,
    };
  }
}
