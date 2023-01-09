''
  autoload -Uz edit-command-line
  zle -N edit-command-line
  bindkey -M vicmd "e" edit-command-line
  eval "$(bindkey -e && bindkey -L)" # emacs bindings を viins に取り込む。プラグインでキーバインドを上書きするため、最初に書く。
''
