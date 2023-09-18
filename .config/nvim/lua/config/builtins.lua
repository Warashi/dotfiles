vim.o.title = true
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 0
vim.o.termguicolors = true
vim.o.number = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.o.showtabline = 2
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader><leader>", "<Cmd>source $MYVIMRC<CR>")
vim.keymap.set("n", "[t", "<Cmd>tabprevious<CR>")
vim.keymap.set("n", "]t", "<Cmd>tabnext<CR>")
vim.keymap.set("n", "[T", "<Cmd>tabfirst<CR>")
vim.keymap.set("n", "]T", "<Cmd>tablast<CR>")


vim.g.loaded_2html_plugin = true
vim.g.loaded_logiPat = true
vim.g.loaded_getscriptPlugin = true
vim.g.loaded_gzip = true
vim.g.loaded_gtags = true
vim.g.loaded_gtags_cscope = true
vim.g.loaded_matchit = true
vim.g.loaded_matchparen = true
vim.g.loaded_netrwFileHandlers = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_netrwSettings = true
vim.g.loaded_rrhelper = true
vim.g.loaded_shada_plugin = true
vim.g.loaded_spellfile_plugin = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_tutor_mode_plugin = true
vim.g.loaded_vimballPlugin = true
vim.g.loaded_zipPlugin = true
