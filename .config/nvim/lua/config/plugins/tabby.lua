local M = {
  "nanozuki/tabby.nvim",
  dependencies = { "EdenEast/nightfox.nvim" },
  lazy = false,
}

function M.config() require("nightfox-extra.tabby") end

return M
