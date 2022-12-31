local M = {
  "yuki-yano/fuzzy-motion.vim",
  dependencies = { "vim-denops/denops.vim" },
  event = "User DenopsReady",
}
function M.init() vim.keymap.set("n", "<leader>f", "<cmd>FuzzyMotion<cr>") end

return M
