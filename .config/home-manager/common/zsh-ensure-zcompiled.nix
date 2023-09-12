''
  function source {
    # ensure_zcompiled $1
    builtin source $1
  }
  function ensure_zcompiled {
    local compiled="$1.zwc"
    if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
      echo "Compiling $1"
      zcompile $1
    fi
  }
''
