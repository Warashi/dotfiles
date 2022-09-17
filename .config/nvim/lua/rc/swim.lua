local job = require("plenary.job")
local ascii = "com.apple.keylayout.US"
local current = nil

function activate(name)
	if name == nil then
		return
	end
	job:new({
		command = "muscat",
		args = { "input-method", "set", name },
	}):sync()
end

function set_current()
	local stdout = ""
	job:new({
		command = "muscat",
		args = { "input-method", "get" },
		on_stdout = function(_, line)
			stdout = stdout .. line
		end,
	}):sync()
	current = stdout
end

function insert_enter()
	activate(current)
end

function insert_leave()
	set_current()
	activate(ascii)
end

local id = vim.api.nvim_create_augroup("ime", {})
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	group = id,
	pattern = "*",
	callback = insert_enter,
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	group = id,
	pattern = "*",
	callback = insert_leave,
})
