local M = {
  "nathom/filetype.nvim",
  lazy = false,
}

M.config = {
    overrides = {
      extensions = {
        tf = "terraform",
        nix = "nix",
      },
    },
  }

return M
