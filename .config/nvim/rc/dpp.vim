set nocompatible

let $CACHE = stdpath("cache")
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif

function InitPlugin(plugin)
  " Search from $CACHE directory
  let dir = $CACHE .. '/dpp/repos/github.com/' .. a:plugin
  if !(dir->isdirectory())
    " Install plugin automatically.
    execute '!git clone https://github.com/' .. a:plugin dir
  endif

  execute 'set runtimepath^='
        \ .. dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endfunction

" NOTE: dpp.vim path must be added
call InitPlugin('Shougo/dpp.vim')
call InitPlugin('Shougo/dpp-ext-lazy')

" Install plugin manager automatically.
for s:plugin in [
      \ 'Shougo/dpp.vim',
      \ 'Shougo/dpp-protocol-git',
      \ 'Shougo/dpp-ext-installer',
      \ 'Shougo/dpp-ext-toml',
      \ 'Shougo/dpp-ext-lazy',
      \ 'vim-denops/denops.vim',
      \ ]->filter({ _, val ->
      \           &runtimepath !~# '/' .. val->fnamemodify(':t') })
  " Search from current directory
  let s:dir = s:plugin->fnamemodify(':t')->fnamemodify(':p')
  if !(s:dir->isdirectory())
    " Search from $CACHE directory
    let s:dir = $CACHE .. '/dpp/repos/github.com/' .. s:plugin
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/' .. s:plugin s:dir
    endif
  endif

  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endfor

"---------------------------------------------------------------------------
" dpp configurations.

" set config path
let $DPP_CONFIG_BASE = stdpath("config") .. "/dpprc"

" Set dpp base path (required)
const s:dpp_base = $CACHE .. '/dpp'

" Set dpp source path (required)
const s:dpp_src = $CACHE .. '/dpp/repos/github.com/Shougo/dpp.vim'
const s:denops_src = $CACHE .. '/dpp/repos/github.com/vim-denops/denops.vim'

" Set dpp runtime path (required)
execute 'set runtimepath^=' .. s:dpp_src

if dpp#min#load_state(s:dpp_base)
  echohl WarningMsg | echomsg 'dpp load_state() is failed' | echohl NONE

  " NOTE: denops.vim and dpp plugins are must be added
  for s:plugin in [
        \   'Shougo/dpp-ext-installer',
        \   'Shougo/dpp-ext-toml',
        \   'Shougo/dpp-protocol-git',
        \   'vim-denops/denops.vim',
        \ ]
    call InitPlugin(s:plugin)
  endfor

  " NOTE: Manual load is needed...
  runtime! plugin/denops.vim

  autocmd MyAutoCmd User DenopsReady
        \ call dpp#make_state(s:dpp_base, '$BASE_DIR/dpp.ts'->expand())
  autocmd MyAutoCmd User Dpp:makeStatePost
        \ echohl WarningMsg | echomsg 'dpp make_state() is done' | echohl NONE
endif

command DppMakeState :call dpp#make_state(s:dpp_base, '$DPP_CONFIG_BASE/config.ts')
command DppInstall :call dpp#async_ext_action('installer', 'install')
command DppUpdate :call dpp#async_ext_action('installer', 'update')

filetype indent plugin on
