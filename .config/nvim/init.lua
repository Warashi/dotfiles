vim.o.t_8f = [[\<Esc>[38;2;%lu;%lu;%lum]] -- 文字色
vim.o.t_8b = [[\<Esc>[48;2;%lu;%lu;%lum]] -- 背景色
vim.g.mapleader = ','

vim.opt.title = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.guifont = 'UDEV Gothic NFLG'

vim.keymap.set('n', '<leader><leader>', ':source $MYVIMRC<CR>', { silent = true })
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { silent = true })

require('rc.swim')
require('rc.packer')

-- 依存がいろいろあるので最後にやる
require('rc.lsp')
