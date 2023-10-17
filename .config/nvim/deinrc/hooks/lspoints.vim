" hook_source {{{
augroup MyAutoCmdLspoints
  autocmd!
  autocmd FileType lua call lspoints#attach('luals')
  autocmd FileType typescript,typescriptreact call lspoints#attach('denols')
  autocmd FileType go call lspoints#attach('gopls')
  autocmd FileType nix call lspoints#attach('nills')
  autocmd FileType vim call lspoints#attach('vimls')
  autocmd FileType toml call lspoints#attach('taplo')
augroup END
" }}}
