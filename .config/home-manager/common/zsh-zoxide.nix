{pkgs}: ''
  setopt extended_glob
  local zoxidesource="''${ZDOTDIR:-$HOME}/zoxidesource.zsh"
  if [[ ! -e ''${zoxidesource}(#qN.mh-24) ]]; then
    echo "update $zoxidesource" >&2
    ${pkgs.zoxide}/bin/zoxide init zsh --cmd j > $zoxidesource
    zcompile $zoxidesource
  fi
  zsh-defer source $zoxidesource
''
