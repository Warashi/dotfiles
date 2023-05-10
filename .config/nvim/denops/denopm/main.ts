import { assertArray, assertString, Denops } from "./deps.ts";
import * as toml from "https://deno.land/std@0.186.0/toml/mod.ts";
import { z } from "https://deno.land/x/zod@v3.16.1/mod.ts";

const pluginSchema = z.object({
  github: z.string().optional(),
  git: z.string().optional(),
});

type Plugin = z.infer<typeof pluginSchema>;

function isPlugin(x: unknown): x is Plugin {
  return pluginSchema.safeParse(x).success;
}

export async function main(denops: Denops): Promise<void> {
  await Promise.resolve();

  denops.dispatcher = {
    async load_toml(base: unknown, fn: unknown): Promise<void> {
      await Promise.resolve();

      assertString(base);
      assertString(fn);
      const configs = toml.parse(Deno.readTextFileSync(fn));
      const plugins = configs.plugins;
      assertArray(plugins, isPlugin);

      for (const plugin of plugins) {
        if (plugin.github === undefined && plugin.git === undefined) {
          continue;
        }
        if (plugin.github !== undefined && plugin.git !== undefined) {
          console.log("[WARN] both github and git is defined", plugin);
          continue;
        }

        if (plugin.github !== undefined) {
          plugin.git = `https://github.com/${plugin.github}`;
        }
        if (plugin.git === undefined) {
          console.log("[ERROR] something is wrong", plugin);
        }
      }
    },
  };
}
