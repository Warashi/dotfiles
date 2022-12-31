local mason = { "williamboman/mason.nvim" }
local mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "my-lspconfig",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function() require("my-lspconfig").mason() end,
}

return {
  mason,
  mason_lspconfig,
}
