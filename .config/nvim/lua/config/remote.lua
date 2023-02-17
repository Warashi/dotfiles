local augroup = vim.api.nvim_create_augroup("WarashiRemote", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = augroup,
	pattern = "OpenFile",
	callback = function()
		vim.b.warashi_remote = true
	end,
})
vim.api.nvim_create_autocmd("TabClosed", {
	group = augroup,
	nested = true,
	pattern = "*",
	callback = function(event)
		if vim.b[event.buf].warashi_remote then
			vim.cmd(string.format("bdelete! %d", event.buf))
		end
	end,
})
