local M = {
  "tamago324/nlsp-settings.nvim",
  dependencies = { "my-lspconfig" },
  event = { "BufReadPre", "BufNewFile" },
}
function M.config() require("my-lspconfig").nlspsettings() end

return M
