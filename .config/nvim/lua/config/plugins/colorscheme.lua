local M = {
  "bluz71/vim-nightfly-colors",
  name = "nightfly",
  lazy = false,
  priority = 1000,
}

function M.config()
  -- load the colorscheme here
  vim.cmd([[colorscheme nightfly]])
end

return M
