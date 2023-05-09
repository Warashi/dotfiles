vim.loader.enable()
vim.api.nvim_create_autocmd("User", {
  pattern = "DenopsPluginPost:warashi-config",
  command = "call denops#request('warashi-config', 'configure', [])",
})
local denops_src = vim.fn.stdpath("cache") .. "/dein/repos/github.com/vim-denops/denops.vim"
if not vim.loop.fs_stat(denops_src) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/vim-denops/denops.vim", denops_src })
end
vim.opt.runtimepath:append(denops_src)
