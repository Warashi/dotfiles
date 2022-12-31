local M = {
  "matsui54/denops-signature_help",
  dependencies = { "vim-denops/denops.vim" },
  event = "User DenopsReady",
}

function M.config() vim.fn["signature_help#enable"]() end

return M
