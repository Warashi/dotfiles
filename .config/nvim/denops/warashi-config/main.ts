import {
  batch,
  Denops,
  echo,
  globals,
  mapping,
  option,
  Semaphore,
  stdpath,
} from "./deps.ts";
import { convert, GitPlugin, plugins } from "./plugins.ts";

export async function main(denops: Denops): Promise<void> {
  if (await globals.get(denops, "config_loaded") === 1) {
    return;
  }
  await globals.set(denops, "config_loaded", 1);
  await builtins(denops);
  await denopm(denops);

  await denops.cmd(
    "command DenopmUpdate call denops#notify('warashi-config', 'update_plugins', [])",
  );
  await denops.cmd("LspStart");

  denops.dispatcher = {
    async update_plugins(): Promise<void> {
      const base = await stdpath(denops, "cache") + "/denopm";

      const sem = new Semaphore(4);
      const job = (dst: string) => {
        return sem.lock(async () => {
          await denops.dispatch("denopm", "update_git", base, dst);
        });
      };

      await Promise.all(plugins.map((p) => convert(p).dst).map(job));

      echo(denops, "updated!");
    },
  };

  echo(denops, "configured!");
}

async function builtins(denops: Denops): Promise<void> {
  await batch(denops, async (denops: Denops) => {
    await option.title.set(denops, true);
    await option.timeoutlen.set(denops, 1000);
    await option.ttimeoutlen.set(denops, 0);
    await option.termguicolors.set(denops, true);
    await option.number.set(denops, true);
    await option.expandtab.set(denops, true);
    await option.tabstop.set(denops, 2);
    await option.shiftwidth.set(denops, 2);
    await option.clipboard.set(denops, "unnamedplus");
    await option.showmode.set(denops, false);
    await option.laststatus.set(denops, 3);

    await globals.set(denops, "mapleader", ",");
    await globals.set(denops, "maplocalleader", ",");

    await mapping.map(denops, "<leader><leader>", "<cmd>source $MYVIMRC<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "<ESC>", "<C-\\><C-n>", {
      mode: "t",
      silent: true,
    });
  });
}

async function denopm(denops: Denops): Promise<void> {
  const base = await stdpath(denops, "cache") + "/denopm";

  for (const p of plugins) {
    await denopm_git(denops, base, convert(p));
  }
}

async function denopm_git(
  denops: Denops,
  base: string,
  p: GitPlugin,
): Promise<void> {
  await denops.dispatch("denopm", "download_git", base, p.dst, p.url);

  if (p.lua_pre != null) {
    await denops.cmd(`lua ${p.lua_pre}`);
  }

  await denops.dispatch("denopm", "load", base, p.dst);

  if (p.lua_post != null) {
    await denops.cmd(`lua ${p.lua_post}`);
  }
}
