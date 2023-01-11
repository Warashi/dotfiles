local M = {
  "nathom/filetype.nvim",
  lazy = false,
}

M.opts = {
  overrides = {
    extensions = {
      tf = "terraform",
      nix = "nix",
    },
  },
}

return M
