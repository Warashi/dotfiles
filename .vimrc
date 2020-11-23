call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-goimports'
Plug 'altercation/vim-colors-solarized'
call plug#end()

syntax enable
set background=dark
colorscheme solarized

autocmd FileType go setlocal omnifunc=lsp#complete
let g:goimports_simplify = 1

