import { batch, Denops, globals, mapping, option } from "./deps.ts";

export async function main(denops: Denops): Promise<void> {
  denops.dispatcher = {
    async configure(): Promise<void> {
      if (await globals.get(denops, "config_loaded") === 1) {
        return;
      }
      await globals.set(denops, "config_loaded", 1);

      await builtins(denops);

      console.log("configured!");
      await Promise.resolve();
    },
  };

  await Promise.resolve();
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

    // await globalOptions.set(denops, "mapleader", ",");
    // await globalOptions.set(denops, "maplocalleader", ",");

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
