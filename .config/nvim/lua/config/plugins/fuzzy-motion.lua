local M = {
  "yuki-yano/fuzzy-motion.vim",
  cmd = "FuzzyMotion",
}
function M.init() vim.keymap.set("n", "<leader>f", "<cmd>FuzzyMotion<cr>") end
return M
