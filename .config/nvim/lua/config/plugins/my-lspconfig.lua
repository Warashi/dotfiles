local M = {
  dir = "~/.config/nvim/my-lspconfig",
  name = "my-lspconfig",
  ft = "go",
}
function M.config() require("my-lspconfig").goimports() end

return M
