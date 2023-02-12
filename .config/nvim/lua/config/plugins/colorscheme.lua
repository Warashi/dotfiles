local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
}

function M.config()
  vim.opt.background = "light"
  -- load the colorscheme here
  vim.cmd([[colorscheme catppuccin-latte]])
end

return M
