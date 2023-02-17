local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "my-lspconfig" },
}

function M.config()
  require("my-lspconfig").null_ls()

  local null_ls = require("null-ls")
  local cspell = require("my-lspconfig.cspell")
  cspell.setup_dicts()

  null_ls.register(cspell.custom_actions)
  require("null-ls.sources").register(cspell.source)
end

return M
