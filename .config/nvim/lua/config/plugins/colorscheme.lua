local M = {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
}
function M.config()
  -- load the colorscheme here
  vim.cmd([[colorscheme dayfox]])
end

return M
