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

-- packer.init({
-- 	profile = {
-- 		enable = true,
-- 	},
-- })
-- packer.reset()
packer.startup(function(use)
	-- packer
	use({ "wbthomason/packer.nvim", opt = true })

	-- 高速化
	use({ "lewis6991/impatient.nvim" })
	use({ "nathom/filetype.nvim" })

	-- libraries
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "MunifTanjim/nui.nvim" })
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("rc.notify")
		end,
	})
	use({ "vim-denops/denops.vim" })

	-- lsp
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "tamago324/nlsp-settings.nvim" })
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("rc.null-ls")
		end,
	})
	use({ "weilbith/nvim-lsp-smag" })

	-- tree-sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("rc.nvim-treesitter")
		end,
	})
	use({
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({})
		end,
	})

	-- languages
	use({ "dag/vim-fish", opt = true, ft = { "fish" } })
	use({ "jjo/vim-cue", opt = true, ft = { "cue" } })
	use({ "gpanders/editorconfig.nvim" })

	-- motion
	use({ "deton/jasegment.vim" })
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- snippets
	use({
		"dcampos/nvim-snippy",
		config = function()
			require("rc.snippets")
		end,
	})

	-- UI
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			require("rc.colorscheme")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("rc.lualine")
		end,
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({
		"obaland/vfiler.vim",
		opt = true,
		cmd = { "VFiler" },
		config = function()
			require("rc.filer")
		end,
		requires = { "obaland/vfiler-column-devicons" },
	})
	use({ "RRethy/vim-illuminate" })
	use({ "hotwatermorning/auto-git-diff" })
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("rc.telescope")
		end,
		requires = {
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{ "jvgrootveld/telescope-zoxide" },
		},
	})
	use({
		"sidebar-nvim/sidebar.nvim",
		config = function()
			require("rc.sidebar")
		end,
	})
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("rc.toggleterm")
		end,
	})
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("rc.aerial")
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		config = function()
			require("rc.bufferline")
		end,
	})
	use({
		"folke/trouble.nvim",
		config = function()
			require("rc.trouble")
		end,
	})

	-- misc
	use({
		"famiu/bufdelete.nvim",
		config = function()
			require("rc.bufdelete")
		end,
	})
	use({ "lambdalisue/guise.vim" })
	use({ "yutkat/confirm-quit.nvim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		packer.sync()
	end
end)
