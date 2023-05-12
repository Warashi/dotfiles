import { Plugin } from "./types.ts";

export const ddu: Plugin[] = [
  {
    org: "github",
    repo: "copilot.vim",
    lua_pre: `vim.g.copilot_no_maps = true`,
  },
  { org: "Warashi", repo: "ddu-source-copilot" },
  { org: "Shougo", repo: "ddu-ui-ff" },
  { org: "matsui54", repo: "ddu-vim-ui-select" },
  { org: "4513ECHO", repo: "ddu-source-emoji" },
  { org: "4513ECHO", repo: "ddu-source-source" },
  { org: "Shougo", repo: "ddu-source-line" },
  { org: "Shougo", repo: "ddu-source-register" },
  { org: "matsui54", repo: "ddu-source-command_history" },
  { org: "shun", repo: "ddu-source-buffer" },
  { org: "tyru", repo: "open-browser.vim" },
  { org: "4513ECHO", repo: "ddu-kind-url" },
  { org: "Shougo", repo: "ddu-kind-file" },
  { org: "Shougo", repo: "ddu-kind-word" },
  { org: "Milly", repo: "ddu-filter-kensaku" },
  {
    org: "Shougo",
    repo: "ddu.vim",
    lua_pre: `
      local start = vim.fn["ddu#start"]
      vim.keymap.set("n", "<leader>d", function() start({ sources = { { name = "source" } } }) end)
      vim.keymap.set("i", "<C-x><C-l>", function() start({ sources = { { name = "copilot", options = { defaultAction = "append" } } } }) end)
      vim.keymap.set("i", "<C-x><C-e>", function() start({ sources = { { name = "emoji", options = { defaultAction = "append" } } } }) end)
    `,
    lua_post: `
      local patch_global = vim.fn["ddu#custom#patch_global"]

      -- ui
      patch_global("ui", "ff")
      patch_global("uiParams", {
        ff = {
          split = "floating",
          floatingBorder = "single",
        },
      })

      -- sources
      patch_global("sources", {})
      patch_global("sourceOptions", {
        ["_"] = { matchers = { "matcher_kensaku" } },
      })
      patch_global("sourceParams", {})

      --- kinds
      patch_global("kindOptions", {
        command_history = { defaultAction = "edit" },
        file = { defaultAction = "open" },
        source = { defaultAction = "execute" },
        ui_select = { defaultAction = "select" },
        url = { defaultAction = "browse" },
        word = { defaultAction = "append" },
      })

      -- key-bindings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff",
        callback = function()
          local action = vim.fn["ddu#ui#ff#do_action"]
          local opts = { buffer = true }
          vim.keymap.set("n", "<CR>", function() action("itemAction") end, opts)
          vim.keymap.set("n", "<Space>", function() action("toggleSelectItem") end, opts)
          vim.keymap.set("n", "i", function() action("openFilterWindow") end, opts)
          vim.keymap.set("n", "q", function() action("quit") end, opts)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff-filter",
        callback = function()
          local opts = { buffer = true }
          vim.keymap.set("i", "<CR>", "<Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>", opts)
          vim.keymap.set("n", "<CR>", "<Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>", opts)
        end,
      })
    `,
  },
];
