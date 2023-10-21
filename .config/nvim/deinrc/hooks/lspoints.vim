" hook_source {{{
call lspoints#load_extensions(['config', 'nvim_diagnostics', 'format', 'hover'])

function s:lspoints_on_attach() abort
  nnoremap <buffer> <space>f <Cmd>call denops#request('lspoints', 'executeCommand', ['format', 'execute', bufnr()])<CR>
  nnoremap <buffer> K <Cmd>call denops#request('lspoints', 'executeCommand', ['hover', 'execute', {'title': 'Hover', 'border': 'single'}])<CR>
  nnoremap <buffer> gd <Cmd>call ddu#start({'name': 'lsp-definition'})<CR>
  nnoremap <buffer> gr <Cmd>call ddu#start({'name': 'lsp-references'})<CR>
  nnoremap <buffer> <space>q <Cmd>call ddu#start({'name': 'lsp-diagnostic'})<CR>
  nnoremap <buffer> <space>ca <Cmd>call ddu#start({'name': 'lsp-codeAction'})<CR>
  vnoremap <buffer> <space>ca <Cmd>call ddu#start({'name': 'lsp-codeAction'})<CR>
endfunction

augroup MyAutoCmdLspoints
  autocmd!
  autocmd User LspointsAttach:* call s:lspoints_on_attach()

  autocmd FileType lua call lspoints#attach('luals')
  autocmd FileType typescript,typescriptreact call lspoints#attach('denols')
  autocmd FileType go call lspoints#attach('gopls')
  autocmd FileType nix call lspoints#attach('nills')
  autocmd FileType vim call lspoints#attach('vimls')
  autocmd FileType toml call lspoints#attach('taplo')
augroup END
" }}}
