local M = {
  "folke/neodev.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  ft = "lua",
}
M.config = {
  library = {
    enabled = true,
    runtime = true,
    types = true,
    plugins = true,
  },
  setup_jsonls = true,
}
return M
