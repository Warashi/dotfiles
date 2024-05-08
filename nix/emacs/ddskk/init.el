(setq skk-server-host "localhost"
      skk-server-portnum 1178
      skk-server-report-response t
      skk-sticky-key ";"
      skk-dcomp-activate t)
(add-to-list 'skk-completion-prog-list
             '(skk-comp-by-server-completion) t)
