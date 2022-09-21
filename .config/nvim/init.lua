require("impatient")
require("rc.disable-defaults")
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("rc.packer")
		require("rc.init")
	end,
})
