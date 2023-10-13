import {
  BaseConfig,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.2/types.ts";
import { Denops } from "https://deno.land/x/dpp_vim@v0.0.2/deps.ts";

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
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    const loadToml = async (path: string, lazy: boolean) =>
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

    const plugins = ([] as Plugin[])
      .concat(await loadToml("$DPP_CONFIG_BASE/dpp.toml", false))
      .concat(await loadToml("$DPP_CONFIG_BASE/libs.toml", false));

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
