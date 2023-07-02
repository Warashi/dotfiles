vim.o.title = true
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 0
vim.o.termguicolors = true
vim.o.number = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"
vim.o.showmode = false
vim.o.laststatus = 3
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>t", "<Cmd>terminal<CR>")
vim.keymap.set("n", "<leader><leader>", "<Cmd>source $MYVIMRC<CR>")

local signs = {
  Error = "\u{ea87} ",
  Warn = "\u{ea6c} ",
  Hint = "\u{ea74} ",
  Info = "\u{f400} ",
}

for sign, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. sign
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
