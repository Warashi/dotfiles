" hook_add {{{
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

function! s:ddu_hijack() abort
  if bufnr('%') != expand('<abuf>')
    return
  endif

  let dir = '<amatch>'->expand()
  if isdirectory(dir)
    " 最後の閉じ括弧のスペースを消すと hook_add の終わりと見なされてしまう
    call ddu#start({'name': 'filer', 'sourceOptions': {'_': {'path': dir} } })
  endif
endfunction

augroup ddu_hijack
  autocmd!
  autocmd VimEnter * call s:ddu_hijack()
augroup END
" }}}
