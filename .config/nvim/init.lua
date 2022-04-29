local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'nvim-treesitter/nvim-treesitter', config = function() require('rc/nvim-treesitter') end}
  use {'romgrk/nvim-treesitter-context', config = function() require('treesitter-context').setup {} end}
  use 'dag/vim-fish'
  use 'jjo/vim-cue'
  use 'gpanders/editorconfig.nvim'
  use {'nvim-lualine/lualine.nvim', config = function() require('rc/nightfox') end, requires = {
    'kyazdani42/nvim-web-devicons',
    'EdenEast/nightfox.nvim',
  }}
  use 'mattn/vim-goimports'
  use 'deton/jasegment.vim'
  use 'obaland/vfiler.vim'
  use 'hotwatermorning/auto-git-diff'
  use 'weilbith/nvim-lsp-smag'
  use {'nvim-telescope/telescope.nvim',
    config = function() require('rc/telescope') end,
    requires = {
      'nvim-lua/plenary.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
  }}
  use {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end}
  use {'hrsh7th/nvim-cmp', 
    config = function() require('rc/lsp') end, 
    requires = {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
      'jose-elias-alvarez/null-ls.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-emoji',
      {'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim'},
      {'hrsh7th/cmp-vsnip', requires = {
        {'hrsh7th/vim-vsnip', config = function() require('rc/vsnip') end},
        'hrsh7th/vim-vsnip-integ',
        'rafamadriz/friendly-snippets'
      }},
  }}
  use 'wakatime/vim-wakatime'
  use 'kevinhwang91/nvim-bqf'
  use 'RRethy/vim-illuminate'
  use {'sidebar-nvim/sidebar.nvim', config = function() require('sidebar-nvim').setup {open = true} end}
  use {'akinsho/toggleterm.nvim', config = function() require('toggleterm').setup {open_mapping = [[<c-\>]], direction = 'float'} end}
  use {'folke/which-key.nvim', config = function() require('which-key').setup {} end}
  use {'stevearc/aerial.nvim', config = function() require('aerial').setup {on_attach = function(bufnr) vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {}) end} end}
  use {'kevinhwang91/nvim-hclipboard', config = function() require('hclipboard').start() end}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.o.t_8f = [[\<Esc>[38;2;%lu;%lu;%lum]] -- 文字色
vim.o.t_8b = [[\<Esc>[48;2;%lu;%lu;%lum]] -- 背景色 
vim.g.mapleader = ',' 
vim.env.EDITOR = 'nvr -cc tabnew'
vim.env.TIG_EDITOR = 'nvr -cc tabnew'
vim.env.GIT_EDITOR = 'nvr -cc tabnew --remote-wait-silent'
vim.cmd([[ autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete ]])
vim.cmd([[ autocmd TermOpen * startinsert ]])
vim.cmd([[ autocmd BufLeave term://* stopinsert ]])

vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = 'menu,menuone,noselect'

vim.api.nvim_set_keymap('n', '<leader><leader>', ':source $MYVIMRC<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap=true, silent=true })
