import { Plugin } from "./types.ts";

export const denops: Plugin[] = [
  {
    org: "vim-skk",
    repo: "skkeleton",
    lua_pre: `
      local function skkeleton_init()
        vim.fn["skkeleton#config"]({
          useSkkServer = true,
          globalDictionaries = { "/dev/null" },
        })
        vim.fn["skkeleton#register_keymap"]("input", ";", "henkanPoint")
        vim.fn["skkeleton#register_kanatable"]("rom", {
          ["~"] = { "～" },
        })
      end
      vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-enable)", { silent = true })
      vim.api.nvim_create_autocmd("User", { pattern = "skkeleton-initialize-pre", callback = skkeleton_init })
    `,
  },
  {
    org: "matsui54",
    repo: "denops-popup-preview.vim",
    lua_post: `vim.fn["popup_preview#enable"]()`,
  },
  {
    org: "matsui54",
    repo: "denops-signature_help",
    lua_post: `
      vim.g.signature_help_config = { contentsStyle = "remainingLabels", viewStyle = "virtual" }
      vim.fn["signature_help#enable"]()
    `,
  },
];
