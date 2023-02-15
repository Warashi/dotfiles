local M = {
  "j-hui/fidget.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "catppuccin/nvim" },
}

M.opts = {
  window = {
    blend = 0,
  },
}

return M
