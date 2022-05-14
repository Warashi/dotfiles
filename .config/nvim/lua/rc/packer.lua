local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end
require('packer').startup(function(use)
  -- packer
  use { 'wbthomason/packer.nvim' }

  -- libraries
  use { 'nvim-lua/plenary.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'MunifTanjim/nui.nvim' }
  use { 'rcarriga/nvim-notify', config = function() require('rc/notify') end }

  -- lsp
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/nvim-lsp-installer' }
  use { 'jose-elias-alvarez/null-ls.nvim', config = function() require('rc/null-ls') end }
  use { 'weilbith/nvim-lsp-smag' }

  -- tree-sitter
  use { 'nvim-treesitter/nvim-treesitter', config = function() require('rc/nvim-treesitter') end }
  use { 'romgrk/nvim-treesitter-context', config = function() require('treesitter-context').setup {} end }

  -- languages
  use { 'dag/vim-fish' }
  use { 'jjo/vim-cue' }
  use { 'gpanders/editorconfig.nvim' }

  -- motion
  use { 'deton/jasegment.vim' }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end }
  use { 'bkad/CamelCaseMotion', config = function() require('rc/camel-case-motion') end }

  -- snippets
  use { 'hrsh7th/vim-vsnip', config = function() require('rc/vsnip') end }
  use { 'rafamadriz/friendly-snippets' }

  -- auto completion
  use { 'hrsh7th/nvim-cmp',
    config = function() require('rc/cmp') end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-vsnip',
      'petertriho/cmp-git',
    },
  }

  -- UI
  use { 'EdenEast/nightfox.nvim', config = function() require('rc/nightfox') end }
  use { 'nvim-lualine/lualine.nvim', config = function() require('rc/lualine') end, requires = { 'kyazdani42/nvim-web-devicons' } }
  use { 'nvim-neo-tree/neo-tree.nvim', config = function() require('rc/neo-tree') end }
  use { 'kevinhwang91/nvim-bqf' }
  use { 'RRethy/vim-illuminate' }
  use { 'hotwatermorning/auto-git-diff' }
  use { 'nvim-telescope/telescope.nvim', config = function() require('rc/telescope') end, requires = { { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } } }
  use { 'sidebar-nvim/sidebar.nvim', config = function() require('sidebar-nvim').setup { open = true } end }
  use { 'akinsho/toggleterm.nvim', config = function() require('rc/toggleterm') end }
  use { 'folke/which-key.nvim', config = function() require('which-key').setup {} end }
  use { 'stevearc/aerial.nvim', config = function() require('rc/aerial') end }
  use { 'akinsho/bufferline.nvim', tag = "v2.*", config = function() require('rc/bufferline') end }

  -- misc
  use { 'wakatime/vim-wakatime' }
  use { 'kevinhwang91/nvim-hclipboard', config = function() require('hclipboard').start() end }
  use { 'famiu/bufdelete.nvim' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
