local M = {
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
}

function M.config()
	-- Disable virtual_text since it's redundant due to lsp_lines.
	vim.diagnostic.config({
		virtual_text = false,
	})
	require("lsp_lines").setup()
end

return M
