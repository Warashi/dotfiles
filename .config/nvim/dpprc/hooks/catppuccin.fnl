; fennel_add {{{
(let [callback (fn []
                 (let [catppuccin (require :catppuccin)]
                   (catppuccin.setup {:flavour :latte
                                      :transparent_background false
                                      :term_colors true
                                      :dim_inactive {:enabled true}
                                      :integrations {:gitsigns true
                                                     :notify true
                                                     :semantic_tokens true
                                                     :treesitter_context true
                                                     :treesitter true
                                                     :sandwich true}})))]
  (vim.api.nvim_create_autocmd :ColorSchemePre
                               {:pattern :catppuccin :once true : callback}))

; }}}
