local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "catppuccin/nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
}

M.opts = {
  options = {
    theme = "catppuccin",
  },
}

return M
