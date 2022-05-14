local null_ls = require('null-ls')
null_ls.setup {
  sources = {
    --- spaces ---
    null_ls.builtins.diagnostics.trail_space,
    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.trim_whitespace,

    --- dictionary / spell ---
    null_ls.builtins.hover.dictionary,
    null_ls.builtins.diagnostics.misspell,
    null_ls.builtins.diagnostics.textlint.with {
      prefer_local = 'node_modules/.bin',
      filetypes = { 'markdown', 'text' },
    },

    --- fish ---
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.fish_indent,
  },
}
