local config_base = vim.fn.stdpath("config") .. "/deinrc/"
local dein_base = vim.fn.stdpath("cache") .. "/dein"
local dein_src = dein_base .. "/repos/github.com/Shougo/dein.vim"
if not vim.loop.fs_stat(dein_src) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/Shougo/dein.vim", dein_src })
end
vim.opt.runtimepath:append(dein_src)

local dein = require("dein")
vim.g["dein#types#git#enable_partial_clone"] = true
dein.setup({
  auto_recache = true,
  auto_remote_plugins = false,
  enable_notification = true,
  install_check_diff = true,
  install_check_remote_threshold = 24 * 60 * 60,
  install_copy_vim = true,
  install_progress_type = true,
  lazy_rplugins = true,
})

vim.env.DEIN_CONFIG_BASE = config_base

if dein.load_state(dein_base) > 0 then
  dein.begin(dein_base)

  dein.load_toml(config_base .. "someone.toml")

  dein.load_toml(config_base .. "ft.toml")
  dein.load_toml(config_base .. "libs.toml")
  dein.load_toml(config_base .. "ui.toml")
  dein.load_toml(config_base .. "ui-lazy.toml", { lazy = true })
  dein.load_toml(config_base .. "libs-lazy.toml", { lazy = true })

  dein.load_toml(config_base .. "ddc.toml", { lazy = true })
  dein.load_toml(config_base .. "ddu.toml", { lazy = true })

  dein.load_toml(config_base .. "lsp.toml", { lazy = true })
  dein.load_toml(config_base .. "snippets.toml", { lazy = true })
  dein.load_toml(config_base .. "treesitter.toml", { lazy = true })

  dein.end_()

  dein.save_state()
end

dein.call_hook("source")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function() dein.call_hook("post_source") end,
  once = true,
})
