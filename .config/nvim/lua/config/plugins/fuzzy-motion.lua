local M = {
  "yuki-yano/fuzzy-motion.vim",
}
function M.init() 
  vim.keymap.set("n", "<leader>f", "<cmd>FuzzyMotion<cr>") 
end
return M
