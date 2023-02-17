local M = {
  "neovim/nvim-lspconfig",
  dependencies = { "folke/neoconf.nvim" },
}

function M.config() require("my-lspconfig").hover_handler_config() end

return M
