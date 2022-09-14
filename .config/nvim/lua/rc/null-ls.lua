local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		--- dictionary / spell ---
		null_ls.builtins.hover.dictionary,
		null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.vale,
		null_ls.builtins.diagnostics.textlint.with({
			prefer_local = "node_modules/.bin",
			filetypes = { "markdown", "text" },
		}),

		--- git ---
		null_ls.builtins.diagnostics.commitlint.with({
			prefer_local = "node_modules/.bin",
		}),

		--- nix ---
		null_ls.builtins.diagnostics.deadnix,
		null_ls.builtins.diagnostics.statix,
		null_ls.builtins.formatting.alejandra,

		--- lua ---
		null_ls.builtins.diagnostics.selene,
		null_ls.builtins.formatting.stylua,

		--- shell ---
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.zsh,
		null_ls.builtins.formatting.shellharden,

		--- other ---
		null_ls.builtins.diagnostics.todo_comments,
	},
})
