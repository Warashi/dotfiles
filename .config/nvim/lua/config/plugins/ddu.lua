local M = {
  "Shougo/ddu.vim",
  dependencies = {
    "vim-denops/denops.vim",

    --- ui ---
    "Shougo/ddu-ui-ff",
    "matsui54/ddu-vim-ui-select",

    --- source ---
    "4513ECHO/ddu-source-emoji",
    "4513ECHO/ddu-source-ghq",
    "4513ECHO/ddu-source-source",
    "Shougo/ddu-source-line",
    "Shougo/ddu-source-register",
    "matsui54/ddu-source-command_history",
    "shun/ddu-source-buffer",

    --- kind ---
    "4513ECHO/ddu-kind-url",
    "Shougo/ddu-kind-file",
    "Shougo/ddu-kind-word",

    ---- ddu-kind-url deps
    "tyru/open-browser.vim",

    --- matcher ---
    "Milly/ddu-filter-kensaku",

    ---- ddu-filter-kensaku deps
    "lambdalisue/kensaku.vim",
  },
}

function M.init()
  local start = vim.fn["ddu#start"]
  vim.keymap.set("n", "<leader>d", function() start({ sources = { { name = "source" } } }) end)
end

function M.config()
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
      vim.keymap.set("i", "<CR>", "<Esc><Cmd>call ddu#ui#ff#close()<CR>", opts)
      vim.keymap.set("n", "<CR>", "<Cmd><Cmd>call ddu#ui#ff#close()<CR>", opts)
    end,
  })
end

return M
