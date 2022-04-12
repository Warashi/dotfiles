local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'nvim-treesitter/nvim-treesitter'
  use 'dag/vim-fish'
  use 'gpanders/editorconfig.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'mattn/vim-goimports'
  use 'deton/jasegment.vim'
  use 'obaland/vfiler.vim'
  use 'hotwatermorning/auto-git-diff'
  use 'weilbith/nvim-lsp-smag'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'windwp/nvim-autopairs'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd([[ let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色 ]])
vim.cmd([[ let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色 ]])

vim.g.mapleader = ',' 
vim.env.EDITOR = 'nvr -cc tabnew'
vim.env.GIT_EDITOR = 'nvr -cc tabnew --remote-wait-silent'
vim.cmd([[ autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete ]])
vim.cmd([[ autocmd TermOpen * startinsert ]])
vim.cmd([[ autocmd BufLeave term://* stopinsert ]])

vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = 'unnamedplus'

require('nightfox').init {
  transparent = true
}
vim.cmd([[ colorscheme nordfox ]])


require('lualine').setup {
  options = {
    theme = "nordfox"
  }
}

require('telescope').load_extension('fzf')

require('nvim-autopairs').setup()

-- Mappings.
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader><leader>', ':source $MYVIMRC<CR>', { noremap=true, silent=true })

---- lsp-settings ----
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'gopls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end


---- nvim-treesitter ----
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  ignore_install = { "swift" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cue = {
  install_info = {
    url = "https://github.com/eonpatapon/tree-sitter-cue", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"},
    branch = "main"
  },
  filetype = "cue", -- if filetype does not agrees with parser name
}
vim.cmd([[autocmd BufNewFile,BufRead *.cue set filetype=cue]])
