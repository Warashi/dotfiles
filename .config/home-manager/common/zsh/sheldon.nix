''
  export SHELDON_CONFIG_DIR="$HOME/.config/sheldon"
  sheldon_cache="$SHELDON_CONFIG_DIR/sheldon.zsh"
  sheldon_toml="$SHELDON_CONFIG_DIR/plugins.toml"
  if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
    sheldon source > $sheldon_cache
    zcompile -R $sheledon_cache
  fi
  source "$sheldon_cache"
  unset sheldon_cache sheldon_toml
''
