" install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-goimports'
Plug 'lifepillar/vim-solarized8'
Plug 'dag/vim-fish'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

set timeoutlen=1000 ttimeoutlen=0
set termguicolors
" $TERMがxterm以外のときは以下を設定する必要がある。
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色

syntax enable
set background=dark
colorscheme solarized8

set expandtab
set tabstop=2
set shiftwidth=2

autocmd FileType go setlocal omnifunc=lsp#complete
let g:goimports_simplify = 1
