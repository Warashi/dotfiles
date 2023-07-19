vim.loader.enable()
require("config.autocmd")
require("config.builtins")
require("config.dein")

vim.api.nvim_create_autocmd("UIEnter", {
  group = "MyAutoCmd",
  callback = function()
    if vim.g.neovide then require("config.neovide") end
  end,
})
