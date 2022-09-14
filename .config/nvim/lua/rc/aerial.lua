require("aerial").setup({
	open_automatic = false,
	close_on_select = true,
	close_automatic_events = { "switch_buffer" },
	show_guides = true,
	on_attach = function(_)
		-- Toggle the aerial window with <leader>a
		vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>", { buffer = true })
		-- Jump forwards/backwards with '{' and '}'
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = true })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = true })
		-- Jump up the tree with '[[' or ']]'
		vim.keymap.set("n", "[[", "<cmd>AerialPrevUp<CR>", { buffer = true })
		vim.keymap.set("n", "]]", "<cmd>AerialNextUp<CR>", { buffer = true })
	end,
})
