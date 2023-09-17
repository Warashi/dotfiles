{pkgs}: ''
  setopt extended_glob
  local direnvsource="''${ZDOTDIR:-$HOME}/direnvsource.zsh"
  if [[ ! -e ''${direnvsource}(#qN.mh-24) ]]; then
    echo "update $direnvsource" >&2
    ${pkgs.direnv}/bin/direnv hook zsh > $direnvsource
    zcompile $direnvsource
  fi
  zsh-defer source $direnvsource
''
