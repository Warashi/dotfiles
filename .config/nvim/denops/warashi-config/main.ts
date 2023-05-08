import {
  batch,
  Denops,
  globals,
  mapping,
  options,
} from "./deps.ts";

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
    await options.set(denops, "title", true);
    await options.set(denops, "timeoutlen", 1000);
    await options.set(denops, "ttimeoutlen", 0);
    await options.set(denops, "termguicolors", true);
    await options.set(denops, "number", true);
    await options.set(denops, "expandtab", true);
    await options.set(denops, "tabstop", 4);
    await options.set(denops, "shiftwidth", 4);
    await options.set(denops, "clipboard", "unnamedplus");
    await options.set(denops, "showmode", false);
    await options.set(denops, "laststatus", 3);

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
