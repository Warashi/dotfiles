-- lua_add {{{
local start = vim.fn["ddu#start"]
vim.keymap.set("n", "<leader>d", function() start({ name = "source" }) end)
vim.keymap.set("i", "<C-x><C-l>", function() start({ name = "copilot" }) end)
vim.keymap.set("i", "<C-x><C-e>", function() start({ name = "emoji" }) end)
-- }}}

-- lua_source {{{
vim.fn["ddu#custom#load_config"](vim.env.DEIN_CONFIG_BASE .. "hooks/ddu.ts")

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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttach_ddu", {}),
  callback = function(ev)
    local start = vim.fn["ddu#start"]
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", function() start({ name = "lsp-definition" }) end, opts)
    vim.keymap.set("n", "gr", function() start({ name = "lsp-references" }) end, opts)
  end,
})
