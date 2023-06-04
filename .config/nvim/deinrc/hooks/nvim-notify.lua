-- lua_source {{{
local notify = require("notify")
notify.setup({
	stages = "slide",
})
vim.notify = notify
-- }}}
