-- lua_add {{{
local start = vim.fn["ddu#start"]
vim.keymap.set("n", "<leader>d", function() start({ sources = { { name = "source" } } }) end)
vim.keymap.set(
  "i",
  "<C-x><C-l>",
  function() start({ sources = { { name = "copilot", options = { defaultAction = "append" } } } }) end
)
vim.keymap.set(
  "i",
  "<C-x><C-e>",
  function() start({ sources = { { name = "emoji", options = { defaultAction = "append" } } } }) end
)
-- }}}

-- lua_source {{{
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
-- }}}
