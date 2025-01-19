{ pkgs, ... }:
{
  home.file.".terminfo" = {
    recursive = true;
    source = pkgs.runCommand "emacs-terminfo" { } ''
      ${pkgs.ncurses}/bin/tic -o $out ${pkgs.emacs.src}/etc/e/eterm-color.ti
    '';
  };
}
