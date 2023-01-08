local M = {
  "Shougo/deol.nvim",
  cmd = "Deol",
}

function M.config() vim.g["deol#prompt_pattern"] = "❯" end

return M
