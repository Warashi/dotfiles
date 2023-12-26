function InitializeSekken()
  call denops#notify('sekken', 'use_default_kana_table', [])
  call denops#notify('sekken', 'set_model', [$HOME .. '/.config/sekken/model.bin.zst'])
  call denops#notify('sekken', 'set_dictionary', [$HOME .. '/.config/sekken/jisyo/SKK-JISYO.L.json'])
endfunction

augroup MyDenopsSekken
  autocmd!
  autocmd User DenopsPluginPost:sekken ++once call InitializeSekken()
augroup END
