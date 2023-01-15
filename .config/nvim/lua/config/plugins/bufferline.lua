local M = {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
}

M.opts = {
  options = {
    mode = "tabs",
    show_close_icon = false,
    show_buffer_close_icons = false,
  },
}

return M
