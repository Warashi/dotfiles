local M = {
  "Shougo/deol.nvim",
  cmd = "Deol",
}

function M.init()
  vim.keymap.set("n", "<leader>d", "<cmd>execute 'Deol' '-toggle' '-cwd='.fnamemodify(expand('%'), ':h')<cr>")
end

function M.config()
  vim.g["deol#prompt_pattern"] = "❯"
  vim.g["deol#floating_border"] = "single"
end

return M
