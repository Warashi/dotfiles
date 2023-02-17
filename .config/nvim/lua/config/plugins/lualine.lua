local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "catppuccin/nvim",
    "nvim-tree/nvim-web-devicons",
  },
}

M.opts = {
  options = {
    theme = "catppuccin",
  },
}

return M
