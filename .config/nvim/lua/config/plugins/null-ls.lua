local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "my-lspconfig" },
  event = { "BufReadPre", "BufNewFile" },
}
function M.config() require("my-lspconfig").null_ls() end

return M
