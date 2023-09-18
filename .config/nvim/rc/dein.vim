let $CACHE = stdpath("cache")
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif

" Install plugin manager automatically.
for s:plugin in [
      \ 'Shougo/dein.vim',
      \ ]->filter({ _, val -> &runtimepath !~# '/' .. val })
  " Search from current directory
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    " Search from $CACHE directory
    let s:dir = $CACHE .. '/dein/repos/github.com/' .. s:plugin
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/' .. s:plugin s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endfor

"---------------------------------------------------------------------------
" dein configurations.

let g:dein#auto_recache = v:true
let g:dein#auto_remote_plugins = v:false
let g:dein#enable_notification = v:true
let g:dein#install_check_diff = v:true
let g:dein#install_check_remote_threshold = 24 * 60 * 60
let g:dein#install_progress_type = 'floating'
let g:dein#lazy_rplugins = v:true
let g:dein#types#git#enable_partial_clone = v:true

let $DEIN_CONFIG_BASE = stdpath("config") .. "/deinrc"

let g:dein#inline_vimrcs = [
      \ '$DEIN_CONFIG_BASE/options.rc.vim',
      \ '$DEIN_CONFIG_BASE/mappings.rc.vim',
      \ '$DEIN_CONFIG_BASE/signs.rc.vim',
      \ ]

let s:path = $CACHE .. '/dein'
if !dein#min#load_state(s:path)
  finish
endif

call dein#begin(s:path, '<sfile>'->expand())

call dein#load_toml('$DEIN_CONFIG_BASE/someone.toml', #{ lazy: 0 })
call dein#load_toml('$DEIN_CONFIG_BASE/ft.toml', #{ lazy: 0 })

call dein#load_toml('$DEIN_CONFIG_BASE/libs.toml', #{ lazy: 0 })
call dein#load_toml('$DEIN_CONFIG_BASE/libs-lazy.toml', #{ lazy: 1 })

call dein#load_toml('$DEIN_CONFIG_BASE/ui.toml', #{ lazy: 0 })
call dein#load_toml('$DEIN_CONFIG_BASE/ui-lazy.toml', #{ lazy: 1 })

call dein#load_toml('$DEIN_CONFIG_BASE/ddc.toml', #{ lazy: 1 })
call dein#load_toml('$DEIN_CONFIG_BASE/ddu.toml', #{ lazy: 1 })

call dein#load_toml('$DEIN_CONFIG_BASE/lsp.toml', #{ lazy: 1 })
call dein#load_toml('$DEIN_CONFIG_BASE/snippets.toml', #{ lazy: 1 })
call dein#load_toml('$DEIN_CONFIG_BASE/treesitter.toml', #{ lazy: 1 })

call dein#end()
call dein#save_state()
