require("filetype").setup({
  overrides = {
    extensions = {
      tf = "terraform",
    },
    complex = {
      ["zsh.nix"] = "nix",
    },
  },
})
