require("nlspsettings").setup({
	config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
	local_settings_dir = ".nlsp-settings",
	local_settings_root_markers_fallback = { ".git" },
	append_default_schemas = true,
	loader = "json",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		local function on_attach(_, bufnr)
			-- omnifunc, tagfunc
			vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
			vim.bo.tagfunc = "v:lua.vim.lsp.tagfunc"

			-- keymaps
			local opts = { silent = true, buffer = true }
			vim.keymap.set("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
			vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
			vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
			vim.keymap.set("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
			vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
			vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
			vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
			vim.keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
			vim.keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
			vim.keymap.set(
				"n",
				"<space>wl",
				"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
				opts
			)
			vim.keymap.set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
			vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
			vim.keymap.set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
			vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
			vim.keymap.set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)

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

		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
})
