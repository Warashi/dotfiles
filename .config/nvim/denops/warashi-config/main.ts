import {
  batch,
  Denops,
  ensureNumber,
  fs,
  globals,
  mapping,
  option,
  stdpath,
} from "./deps.ts";
import { plugins } from "./plugins.ts";

export async function main(denops: Denops): Promise<void> {
  if (await globals.get(denops, "config_loaded") === 1) {
    return;
  }
  await globals.set(denops, "config_loaded", 1);
  await builtins(denops);
  await denopm(denops);
  // await dein(denops);
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
    await denops.dispatch("denopm", "download_github", base, p.org, p.repo);

    if (p.lua_pre != null) {
      await denops.cmd(`lua ${p.lua_pre}`);
    }

    await denops.dispatch("denopm", "add_rtp_github", base, p.org, p.repo);

    if (p.lua_post != null) {
      await denops.cmd(`lua ${p.lua_post}`);
    }
  }
  
  await denops.cmd("runtime plugin/**/*.vim");
}

async function dein(denops: Denops): Promise<void> {
  const config_base = await stdpath(denops, "config") + "/deinrc/";
  const dein_base = await stdpath(denops, "cache") + "/dein";
  const dein_src = dein_base + "/repos/github.com/Shougo/dein.vim";
  if (!await fs.exists(dein_src)) {
    await new Deno.Command("git", {
      args: [
        "clone",
        "--filter=blob:none",
        "https://github.com/SHougo/dein.vim",
        dein_src,
      ],
    }).spawn().status;
  }

  option.runtimepath.set(
    denops,
    (await option.runtimepath.get(denops)) + "," + dein_src,
  );

  globals.set(denops, "dein#types#git#enable_partial_clone", true);

  if (ensureNumber(await denops.call("dein#load_state", dein_base)) > 0) {
    batch(denops, async (denops: Denops) => {
      await denops.call("dein#begin", dein_base);
      await denops.call("dein#load_toml", config_base + "dein.toml");
      await denops.call("dein#load_toml", config_base + "deinlazy.toml", {
        lazy: true,
      });
      await denops.call("dein#load_toml", config_base + "deinft.toml");

      await denops.call("dein#load_toml", config_base + "denops.toml");
      await denops.call("dein#load_toml", config_base + "treesitter.toml", {
        lazy: true,
      });
      await denops.call("dein#load_toml", config_base + "lsp.toml", {
        lazy: true,
      });
      await denops.call("dein#load_toml", config_base + "ddc.toml", {
        lazy: true,
      });
      await denops.call("dein#load_toml", config_base + "ddu.toml", {
        lazy: true,
      });

      await denops.call("dein#end");
      await denops.call("dein#save_state");
    });
  }

  await denops.call("dein#call_hook", "source");
  await denops.call("dein#source");
}
