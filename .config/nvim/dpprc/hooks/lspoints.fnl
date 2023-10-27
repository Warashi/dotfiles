; fennel_source {{{
(vim.fn.lspoints#load_extensions [:config :nvim_diagnostics :format :hover])
(fn on_attach []
  (vim.keymap.set :n :<space>f
                  (fn []
                    (vim.fn.denops#request :lspoints :executeCommand
                                           [:format :execute (vim.fn.bufnr)])))
  (when (not (= "LspointsAttach:efmls" (vim.fn.expand :<amatch>)))
    (let [m [{:mode :n
              :key :K
              :callback (fn []
                          (vim.fn.denops#request :lspoints :executeCommand
                                                 [:hover
                                                  :execute
                                                  {:title :Hover
                                                   :border :single}]))}
             {:mode :n
              :key :gd
              :callback (fn [] (vim.fn.ddu#start {:name :lsp-definition}))}
             {:mode :n
              :key :gr
              :callback (fn [] (vim.fn.ddu#start {:name :lsp-references}))}
             {:mode :n
              :key :<space>q
              :callback (fn [] (vim.fn.ddu#start {:name :lsp-diagnostic}))}
             {:mode :n
              :key :<space>ca
              :callback (fn [] (vim.fn.ddu#start {:name :lsp-codeAction}))}
             {:mode :v
              :key :<space>ca
              :callback (fn [] (vim.fn.ddu#start {:name :lsp-codeAction}))}]]
      (each [_ map (ipairs m)]
        (vim.keymap.set map.mode map.key map.callback {:buffer true})))))

(let [id (vim.api.nvim_create_augroup :MyAutoCmdLspoints {})
      lsps [{:filetype :fennel :name :fennells}
            {:filetype :lua :name :luals}
            {:filetype :nix :name :nills}
            {:filetype :toml :name :taplo}
            {:filetype "typescript,typescriptreact" :name :denols}
            {:filetype :vim :name :vimls}
            {:filetype "*" :name :efmls}]]
  (vim.api.nvim_create_autocmd :User
                               {:pattern "LspointsAttach:*"
                                :callback on_attach
                                :group id})
  (each [_ lsp (ipairs lsps)]
    (vim.api.nvim_create_autocmd :Filetype
                                 {:pattern lsp.filetype
                                  :callback (fn []
                                              (vim.fn.lspoints#attach lsp.name))
                                  :group id})))

; }}}
