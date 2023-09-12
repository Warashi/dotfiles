{pkgs}: ''
  setopt extended_glob
  local starshipsource="''${ZDOTDIR:-$HOME}/starshipsource.zsh"
  if [[ ! -e ''${starshipsource}(#qN.mh-24) ]]; then
    echo "update $starshipsource" >&2
    ${pkgs.starship}/bin/starship init zsh --print-full-init > $starshipsource
    zcompile $starshipsource
  fi
  source $starshipsource
''
