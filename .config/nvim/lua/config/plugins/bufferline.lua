local M = {
  "akinsho/bufferline.nvim",
  dependencies = {
    "catppuccin",
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  require("bufferline").setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
      mode = "tabs",
      show_close_icon = false,
      show_buffer_close_icons = false,
    },
  })
end

return M
