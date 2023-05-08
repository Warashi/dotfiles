vim.loader.enable()
-- require("config.options")
vim.api.nvim_create_autocmd("User", {
  pattern = "DenopsPluginPost:warashi-config",
  command = "call denops#request('warashi-config', 'configure', [])",
})
require("config.dein")
