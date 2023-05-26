''
  autoload -Uz edit-command-line
  zle -N edit-command-line
  bindkey "\Ee" edit-command-line # ESC e で edit-command-line を発動させる
  bindkey "^x" denovo-fzf-ghq-cd
  bindkey ' '  denovo-abbrev-expand
  bindkey '^m' denovo-abbrev-expand-and-accept-line
''
