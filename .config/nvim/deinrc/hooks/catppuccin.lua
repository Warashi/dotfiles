-- lua_source {{{
require("catppuccin").setup({
  transparent_background = true,
  dim_inactive = {
    enabled = true,
  },
  integrations = {
    fern = true,
    fidget = true,
    gitsigns = true,
    native_lsp = { enabled = true },
    navic = { enabled = true },
    notify = true,
    semantic_tokens = true,
    treesitter_context = true,
    treesitter = true,
    sandwich = true,
  },
})
vim.cmd([[colorscheme catppuccin-latte]])
-- }}}
