local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/nvim-lsp-installer' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'nvim-treesitter/nvim-treesitter', config = function() require('rc/nvim-treesitter') end }
  use { 'romgrk/nvim-treesitter-context', config = function() require('treesitter-context').setup {} end }
  use 'dag/vim-fish'
  use 'jjo/vim-cue'
  use 'gpanders/editorconfig.nvim'
  use { 'nvim-lualine/lualine.nvim', config = function() require('rc/nightfox') end, requires = {
    'kyazdani42/nvim-web-devicons',
    'EdenEast/nightfox.nvim',
  } }
  use 'deton/jasegment.vim'
  use { 'nvim-neo-tree/neo-tree.nvim',
    config = function() require('rc/neo-tree') end,
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    }
  }
  use 'hotwatermorning/auto-git-diff'
  use 'weilbith/nvim-lsp-smag'
  use { 'nvim-telescope/telescope.nvim',
    config = function() require('rc/telescope') end,
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    } }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end }
  use { 'hrsh7th/vim-vsnip', config = function() require('rc/vsnip') end }
  use 'rafamadriz/friendly-snippets'
  use { 'hrsh7th/nvim-cmp',
    config = function() require('rc/cmp') end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-vsnip',
      { 'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim' },
    },
  }
  use 'wakatime/vim-wakatime'
  use 'kevinhwang91/nvim-bqf'
  use 'RRethy/vim-illuminate'
  use { 'sidebar-nvim/sidebar.nvim', config = function() require('sidebar-nvim').setup { open = true } end }
  use { 'akinsho/toggleterm.nvim', config = function() require('rc/toggleterm') end }
  use { 'folke/which-key.nvim', config = function() require('which-key').setup {} end }
  use { 'stevearc/aerial.nvim', config = function() require('rc/aerial') end }
  use { 'kevinhwang91/nvim-hclipboard', config = function() require('hclipboard').start() end }
  use { 'bkad/CamelCaseMotion', config = function() require('rc/camel-case-motion') end }
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('rc/bufferline') end,
  }
  use 'famiu/bufdelete.nvim'
  use { 'rcarriga/nvim-notify', config = function() require('rc/notify') end }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
