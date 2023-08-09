" hook_add {{{
nnoremap : <Cmd>call CommandlinePre(':')<CR>:
xnoremap : <Cmd>call CommandlinePre(':')<CR>:

function! CommandlinePre(mode) abort
  " Overwrite sources
  let b:prev_buffer_config = ddc#custom#get_buffer()

  if a:mode ==# ':'
    call ddc#custom#patch_buffer('keywordPattern', '[0-9a-zA-Z_:#-]*')
  endif

  autocmd MyAutoCmd User DDCCmdlineLeave ++once call CommandlinePost()

  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
  " Restore config
  if 'b:prev_buffer_config'->exists()
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  endif
endfunction
" }}}

" hook_source {{{
cnoremap <C-f> <Cmd>call pum#close()<CR><C-f>
" }}}
