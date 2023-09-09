" hook_add {{{
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

function! s:ddu_hijack() abort
  if bufnr('%') != expand('<abuf>')
    return
  endif

  if isdirectory('<amatch>'->expand())
    call ddu#start({'name': 'filer'})
  endif
endfunction

augroup ddu_hijack
  autocmd!
  autocmd VimEnter * call s:ddu_hijack()
augroup END
" }}}
