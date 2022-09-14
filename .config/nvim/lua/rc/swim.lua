vim.cmd([[

" input method
let s:Ascii = 'com.apple.keylayout.US'
let s:Current = system('muscat input-method get')

function! s:ImActivateFunc(name)
  call system('muscat input-method set ' . a:name)
endfunction

function! s:insertEnter()
  call s:ImActivateFunc(s:Current)
endfunction

function! s:insertLeave()
  let s:Current = system('muscat input-method get')
  call s:ImActivateFunc(s:Ascii)
endfunction

augroup ime
  autocmd!
  autocmd InsertEnter * call s:insertEnter()
  autocmd InsertLeave * call s:insertLeave()
augroup END

]])
