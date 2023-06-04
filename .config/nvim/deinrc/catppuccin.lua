-- lua_source {{{
require("catppuccin").setup({
	integrations = {
		aerial = true,
		bufferline = true,
		gitsigns = true,
		illuminate = true,
		lsp_trouble = true,
		mason = true,
		notify = true,
		nvimtree = true,
		sandwich = true,
		semantic_tokens = true,
		treesitter = true,
		treesitter_context = true,

		native_lsp = {
			enabled = true,
		},
	},
})
vim.cmd([[colorscheme catppuccin-latte]])
-- }}}
