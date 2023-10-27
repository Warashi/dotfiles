; fennel_source {{{
(local treesitter (require :nvim-treesitter.configs))
(treesitter.setup {:sync_install false
                   :highlight {:enable true
                               :additional_vim_regex_highlighting true}})

; }}}
