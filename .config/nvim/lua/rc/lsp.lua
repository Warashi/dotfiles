-- Setup Go organize imports
require("rc.goimports")

-- format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.formatting_seq_sync(nil, 1000)]])

require("rc.lsp-keymaps")

require("mason").setup({})
require("nlspsettings").setup({})
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
	function(server_name)
		local on_attach = function(client, bufnr)
			-- omnifunc
			vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

			-- aerial
			require("aerial").on_attach(client, bufnr)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		lspconfig[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
})
