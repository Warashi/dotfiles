local M = {
  "feline-nvim/feline.nvim",
  dependencies = { "EdenEast/nightfox.nvim" },
  lazy = false,
}

function M.config() require("nightfox-extra.feline") end

return M
