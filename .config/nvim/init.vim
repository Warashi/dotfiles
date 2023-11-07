" 標準的なXDG環境変数を設定しておく
if $XDG_CONFIG_HOME ==# ''
  let $XDG_CONFIG_HOME = stdpath("config")->fnamemodify(":p:h:h")
endif
if $XDG_CACHE_HOME ==# ''
  let $XDG_CACHE_HOME = stdpath("cache")->fnamemodify(":p:h:h")
endif
if $XDG_DATA_HOME ==# ''
  let $XDG_DATA_HOME = stdpath("data")->fnamemodify(":p:h:h")
endif
if $XDG_STATE_HOME ==# ''
  let $XDG_STATE_HOME = stdpath("state")->fnamemodify(":p:h:h")
endif

" 探索パスを減らすことでちょっとだけ高速化するかも
set rtp=
set rtp=$VIMRUNTIME
set rtp^=$XDG_DATA_HOME/nvim/site
set rtp+=$XDG_DATA_HOME/nvim/site/after
set rtp^=$XDG_CONFIG_HOME/nvim
set rtp+=$XDG_CONFIG_HOME/nvim/after
set packpath=

language message C

augroup MyAutoCmd
  autocmd!
augroup END

" vim.loader 使った方がなぜか遅いんじゃが…
" lua if vim.loader then vim.loader.enable() end

let s:base_path = fnamemodify(expand('<sfile>'), ':h')

execute 'source' s:base_path .. '/rc/dpp.vim'

" load colorscheme after dpp.vim because manage colorscheme plugin with dpp.vim
execute 'source' s:base_path .. '/rc/colorscheme.vim'
