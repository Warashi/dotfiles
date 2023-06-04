-- lua_source {{{
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    --- nix ---
    null_ls.builtins.diagnostics.deadnix,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.formatting.alejandra,

    --- lua ---
    null_ls.builtins.diagnostics.selene.with({
      cwd = function() return require("null-ls.utils").root_pattern("selene.toml")(vim.api.nvim_buf_get_name(0)) end,
    }),
    null_ls.builtins.formatting.stylua.with({
      cwd = function() return require("null-ls.utils").root_pattern("stylua.toml")(vim.api.nvim_buf_get_name(0)) end,
    }),

    --- shell ---
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.shfmt,

    --- other ---
    null_ls.builtins.diagnostics.todo_comments,
  },
})
-- }}}