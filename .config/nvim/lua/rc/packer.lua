local function ensure_packer()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
  if not (fn.empty(fn.glob(install_path)) > 0) then
    vim.cmd([[packadd packer.nvim]])
    return false
  end
  fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd([[packadd packer.nvim]])
  return true
end

local packer_bootstrap = ensure_packer()
local packer = require("packer")

packer.init({
  profile = {
    enable = true,
  },
})
packer.reset()
packer.startup(function(use)
  -- packer
  use({ "wbthomason/packer.nvim", opt = true })

  -- 高速化
  use({ "lewis6991/impatient.nvim" })
  use({
    "nathom/filetype.nvim",
    config = function() require("rc.filetype") end,
  })

  -- libraries
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "MunifTanjim/nui.nvim" })
  use({
    "rcarriga/nvim-notify",
    config = function() require("rc.notify") end,
    event = "VimEnter",
  })
  use({ "vim-denops/denops.vim" })

  -- lsp
  use({ "neovim/nvim-lspconfig" })
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })
  use({ "tamago324/nlsp-settings.nvim" })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({
    "folke/neodev.nvim",
    config = function() require("rc.neodev") end,
    event = "VimEnter",
  })

  -- tree-sitter
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function() require("rc.nvim-treesitter") end,
  })
  use({
    "romgrk/nvim-treesitter-context",
    config = function() require("treesitter-context").setup({}) end,
    event = "VimEnter",
  })

  -- languages
  use({ "dag/vim-fish", opt = true, ft = { "fish" } })
  use({ "jjo/vim-cue", opt = true, ft = { "cue" } })
  use({ "gpanders/editorconfig.nvim" })

  -- motion
  use({ "deton/jasegment.vim" })
  use({
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup({}) end,
    event = "VimEnter",
  })

  -- snippets
  use({
    "hrsh7th/vim-vsnip",
    config = function() require("rc.snippets") end,
    event = "VimEnter",
  })
  use({
    "hrsh7th/vim-vsnip-integ",
    opt = true,
  })

  -- UI
  use({
    "RRethy/nvim-base16",
    config = function() require("rc.colorscheme") end,
    -- event = "VimEnter",
  })
  use({
    "vimpostor/vim-tpipeline",
    config = function() require("rc.tpipeline") end,
  })
  use({ "RRethy/vim-illuminate" })
  use({ "hotwatermorning/auto-git-diff" })
  use({
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end,
    event = "VimEnter",
  })
  use({
    "akinsho/toggleterm.nvim",
    config = function() require("rc.toggleterm") end,
    event = "VimEnter",
  })
  use({
    "folke/which-key.nvim",
    config = function() require("which-key").setup({}) end,
    event = "VimEnter",
  })
  use({
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function() require("rc.trouble") end,
  })

  -- pum
  use({ "Shougo/pum.vim" })

  -- ddu
  use({ "Shougo/ddu-commands.vim" })
  use({ "Shougo/ddu-filter-matcher_substring" })
  use({ "Shougo/ddu-kind-file" })
  use({ "Shougo/ddu-kind-word" })
  use({ "Shougo/ddu-source-file" })
  use({ "Shougo/ddu-source-file_rec" })
  use({ "Shougo/ddu-source-register" })
  use({ "Shougo/ddu-ui-ff" })
  use({ "kuuote/ddu-source-mr" })
  use({ "lambdalisue/mr.vim" })
  use({ "matsui54/ddu-source-file_external" })
  use({ "shun/ddu-source-buffer" })
  use({ "shun/ddu-source-rg" })
  use({
    "Shougo/ddu.vim",
    config = function() require("rc.ddu") end,
  })

  -- ddc
  use({ "Shougo/ddc-around" })
  use({ "Shougo/ddc-cmdline" })
  use({ "Shougo/ddc-cmdline-history" })
  use({ "Shougo/ddc-converter_remove_overlap" })
  use({ "Shougo/ddc-nvim-lsp" })
  use({ "Shougo/ddc-ui-pum" })
  use({ "LumaKernel/ddc-file" })
  use({ "tani/ddc-fuzzy" })
  use({
    "Shougo/ddc.vim",
    config = function() require("rc.autocomplete") end,
  })

  -- misc
  use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })
  use({ "lambdalisue/guise.vim" })
  use({ "yutkat/confirm-quit.nvim" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then packer.sync() end
end)
