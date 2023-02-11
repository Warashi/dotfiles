local M = {
  "lambdalisue/kensaku-search.vim",
  dependencies = { "lambdalisue/kensaku.vim" },
  lazy = false,
}

function M.config() vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>", {}) end

return M
