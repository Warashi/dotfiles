''
  if [[ -n $ZENO_LOADED ]]; then
    bindkey ' '  zeno-auto-snippet
    bindkey '^m' zeno-auto-snippet-and-accept-line
    bindkey '^i' zeno-completion
    bindkey '^r' zeno-history-selection
    bindkey '^x' zeno-ghq-cd
  fi
''
