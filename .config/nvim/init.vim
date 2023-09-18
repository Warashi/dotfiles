augroup MyAutoCmd
  autocmd!
augroup END

lua if vim.loader then vim.loader.enable() end

let s:base_path = fnamemodify(expand('<sfile>'), ':h')
execute 'source' s:base_path .. '/rc/dein.vim'
execute 'source' s:base_path .. '/rc/colorscheme.vim'

language message C
set secure
