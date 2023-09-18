-- lua_add {{{
vim.api.nvim_create_autocmd("ColorSchemePre", {
  pattern = "catppuccin-latte",
  callback = function()
    require("catppuccin").setup({
      transparent_background = false,
      term_colors = true,
      dim_inactive = {
        enabled = true,
      },
      integrations = {
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
  end,
})
-- }}}
