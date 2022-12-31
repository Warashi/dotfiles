local M = {
  "matsui54/denops-popup-preview.vim",
  dependencies = {
    "vim-denops/denops.vim",
  },
  event = "VeryLazy",
}

function M.config() vim.fn["popup_preview#enable"]() end

return M
