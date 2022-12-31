local M = {
  "folke/trouble.nvim",
  config = true,
  cmd = "TroubleToggle",
}

function M.init() vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>") end

return M
