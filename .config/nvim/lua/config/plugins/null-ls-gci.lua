local M = {
	dir = "~/.config/nvim/null-ls-gci",
	dependencies = {
		"my-lspconfig",
		"nvim-lua/plenary.nvim",
		"jose-elias-alvarez/null-ls.nvim",
	},
}

function M.config()
	if vim.fn["executable"]("gci") > 0 then
		local source = require("null-ls-gci").source
		require("null-ls.sources").register(source)
	end
end

return M
