call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-goimports'
call plug#end()

autocmd FileType go setlocal omnifunc=lsp#complete
let g:goimports_simplify = 1
