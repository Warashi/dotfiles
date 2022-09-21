require("mason").setup({})
require("nlspsettings").setup({
	config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
	local_settings_dir = ".nlsp-settings",
	local_settings_root_markers_fallback = { ".git" },
	append_default_schemas = true,
	loader = "json",
})
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
	function(server_name)
		local on_attach = function(_, bufnr)
			-- omnifunc
			vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

			-- format on save
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_seq_sync(nil, 1000)
				end,
			})
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		lspconfig[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
})
