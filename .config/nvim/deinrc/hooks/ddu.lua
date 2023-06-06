-- lua_add {{{
-- ddu-ui-filer を使うので netrw は読み込まない
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

local start = vim.fn["ddu#start"]
vim.keymap.set("n", "<leader>d", function() start({ name = "source" }) end)
vim.keymap.set("n", "<leader>f", function() start({ name = "filer" }) end)
vim.keymap.set("i", "<C-x><C-l>", function() start({ name = "copilot" }) end)
vim.keymap.set("i", "<C-x><C-e>", function() start({ name = "emoji" }) end)

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   callback = function(args)
--     local dirname = vim.fn.expand(args.match)
--     if vim.fn.isdirectory(dirname) > 0 then
--       vim.fn["ddu#start"]({ name = "filer", sourceOptions = { path = dirname } })
--     end
--   end,
-- })
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ddu-filer",
  callback = function()
    local action = vim.fn["ddu#ui#filer#do_action"]
    local opts = { buffer = true }
    vim.keymap.set("n", "<CR>", function() action("itemAction") end, opts)
    vim.keymap.set("n", "<Space>", function() action("toggleSelectItem") end, opts)
    vim.keymap.set("n", "o", function() action("expandItem") end, opts)
    vim.keymap.set("n", "q", function() action("quit") end, opts)
  end,
})
-- }}}
