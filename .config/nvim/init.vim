" 探索パスを減らすことでちょっとだけ高速化するかも
set rtp=$XDG_CONFIG_HOME/nvim,$VIMRUNTIME
set packpath=
language message C

augroup MyAutoCmd
  autocmd!
augroup END

lua if vim.loader then vim.loader.enable() end

let s:base_path = fnamemodify(expand('<sfile>'), ':h')
execute 'source' s:base_path .. '/rc/dein.vim'
execute 'source' s:base_path .. '/rc/colorscheme.vim'
