-- Setup Go organize imports
require('rc.goimports')

-- format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_seq_sync(nil, 1000)]]

require('rc.lsp-keymaps')

require('nvim-lsp-installer').setup {}
require('nlspsettings').setup {}
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  -- omnifunc
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- aerial
  require('aerial').on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'gopls', 'sumneko_lua', 'clangd', 'rnix' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
