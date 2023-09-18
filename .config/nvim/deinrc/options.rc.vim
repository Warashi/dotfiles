if has('vim_starting') && argv()->empty()
  " Disable auto syntax loading
  syntax off
endif

set title
set timeoutlen=1000
set ttimeoutlen=0
set termguicolors
set number
set expandtab
set tabstop=2
set shiftwidth=2
set clipboard+=unnamedplus
set signcolumn=yes
set noshowmode
set cmdheight=0
set laststatus=3
set showtabline=2
let g:mapleader=","
let g:maplocalleader=","
set background=light
