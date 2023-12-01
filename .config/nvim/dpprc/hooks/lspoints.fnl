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
      lsps [{:filetype "typescript,typescriptreact" :name :denols}
            {:filetype :fennel :name :fennells}
            {:filetype :go :name :gopls}
            {:filetype :lua :name :luals}
            {:filetype :markdown :name :zk}
            {:filetype :nix :name :nills}
            {:filetype :rust :name :rust_analyzer}
            {:filetype :toml :name :taplo}
            {:filetype :vim :name :vimls}]]
  (vim.api.nvim_create_autocmd :User
                               {:pattern "LspointsAttach:*"
                                :callback on_attach
                                :group id})
  (each [_ lsp (ipairs lsps)]
    (vim.api.nvim_create_autocmd :Filetype
                                 {:pattern lsp.filetype
                                  :callback (fn []
                                              (when (= vim.o.buftype "")
                                                (vim.fn.lspoints#attach lsp.name)))
                                  :group id})))

; }}}
