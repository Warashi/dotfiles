call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-goimports'
call plug#end()

syntax enable
set background=dark

autocmd FileType go setlocal omnifunc=lsp#complete
let g:goimports_simplify = 1

