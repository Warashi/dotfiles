local M = {
	"rcarriga/nvim-notify",
}

function M.config()
	require("notify").setup({
		stages = "slide",
	})
	vim.notify = require("notify")
end

return M
