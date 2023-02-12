vim.opt.title = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,longest,preview"
vim.opt.guifont = "UDEV Gothic NFLG"
vim.opt.showmode = false
vim.opt.laststatus = 3

vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader><leader>", "<cmd>source $MYVIMRC<cr>", { silent = true })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { silent = true })
