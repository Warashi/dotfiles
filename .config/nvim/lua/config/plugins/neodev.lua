local M = {
  "folke/neodev.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
}
M.opts = {
  library = {
    enabled = true,
    runtime = true,
    types = true,
    plugins = true,
  },
  setup_jsonls = true,
}
return M
