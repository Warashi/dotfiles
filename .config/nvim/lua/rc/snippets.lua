local snippy = require("snippy")
snippy.setup({
	mappings = {
		is = {
			["<Tab>"] = "expand_or_advance",
			["<S-Tab>"] = "previous",
		},
		nx = {
			["<leader>x"] = "cut_text",
		},
	},
})
vim.api.nvim_create_autocmd("CompleteDone", {
	callback = snippy.complete_done,
})
