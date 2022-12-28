--- disable defaults ---
vim.g.did_install_default_menus = true
vim.g.did_install_syntax_menu = true
vim.g.did_indent_on = true
vim.g.did_load_filetypes = true
vim.g.did_load_ftplugin = true
vim.g.loaded_2html_plugin = true
vim.g.loaded_gzip = true
vim.g.loaded_matchit = true
vim.g.loaded_matchparen = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_remote_plugins = true
vim.g.loaded_shada_plugin = true
vim.g.loaded_spellfile_plugin = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_tutor_mode_plugin = true
vim.g.loaded_zipPlugin = true
vim.g.skip_loading_mswin = true

--- termguicolors ---
vim.o.t_8f = [[\<Esc>[38;2;%lu;%lu;%lum]] -- 文字色
vim.o.t_8b = [[\<Esc>[48;2;%lu;%lu;%lum]] -- 背景色

--- set opts ---
vim.opt.title = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,longest,preview"
vim.opt.background = "dark"
vim.opt.guifont = "UDEV Gothic NFLG"
vim.opt.showmode = false
vim.opt.laststatus = 3

--- misc keymaps ---
vim.g.mapleader = ","
vim.keymap.set("n", "<leader><leader>", ":source $MYVIMRC<CR>", { silent = true })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { silent = true })

--- configure dein.vim ---
local config_base = vim.fn.stdpath("config") .. "/"
local dein_base = vim.env.HOME .. "/.cache/dein"
local dein_src = dein_base .. "/repos/github.com/Shougo/dein.vim"

--- ensure dein ---
if vim.fn.empty(vim.fn.glob(dein_src)) > 0 then
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

if dein.load_state(dein_base) > 0 then
  dein.begin(dein_base)

  dein.load_toml(config_base .. "libraries.toml")
  dein.load_toml(config_base .. "dein.toml")
  dein.load_toml(config_base .. "deinlazy.toml", { lazy = true })
  dein.load_toml(config_base .. "ui.toml", { lazy = true })
  dein.load_toml(config_base .. "lsp.toml", { lazy = true })
  dein.load_toml(config_base .. "ddc.toml", { lazy = true })

  dein.end_()

  dein.save_state()
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    dein.call_hook("source")
    dein.call_hook("post_source")
  end,
})
