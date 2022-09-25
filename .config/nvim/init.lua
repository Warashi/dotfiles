require("impatient")
require("rc.disable-defaults")
require("rc.packer")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function() require("rc.init") end,
})
