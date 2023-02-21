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
  override = function(root_dir, library)
    if vim.endswith(root_dir, "dotfiles") then
      library.enabled = true
      library.runtime = true
      library.types = true
      library.plugins = true
    end
  end,
}
return M
