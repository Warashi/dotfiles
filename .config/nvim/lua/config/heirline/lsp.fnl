(fn condition []
  (if (= 1 ((. vim :fn "denops#plugin#is_loaded") :lspoints))
      (< 0 (length ((. vim :fn "lspoints#get_clients"))))
      false))

(fn init [self]
  (if (not (rawget self :once))
      ((. vim :api :nvim_create_autocmd) :BufWinEnter
                                         {:callback (fn []
                                                      (tset self :_win_cache
                                                            nil))})
      (tset self :once true)))

(fn provider [_]
  (let [format " [%s]"
        servers (icollect [_ server (ipairs ((. vim :fn "lspoints#get_clients")))]
                  (. server :name))]
    (format:format (table.concat servers ", "))))

{: condition
 :update {1 :User
          :pattern ["LspointsAttach:*"
                    "LspointsDetach:*"
                    "DenopsPluginPost:lspoints"]}
 : init
 : provider
 :hl {:fg :green :bold true}}
