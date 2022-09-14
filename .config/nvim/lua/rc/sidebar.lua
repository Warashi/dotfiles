local sidebar = require("sidebar-nvim")
sidebar.setup({
	open = false,
	sections = { "datetime", "git", "diagnostics", "todos" },
})

vim.keymap.set("n", "<leader>s", sidebar.toggle, { silent = true })
