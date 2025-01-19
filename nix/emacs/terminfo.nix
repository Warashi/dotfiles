{ pkgs, ... }:
let
  generated = pkgs.callPackage ./_sources/generated.nix { };
  eterm-color = pkgs.writeText "eterm-color.ti" generated.emacs-src."etc/e/eterm-color.ti";
in
{
  home.file.".terminfo" = {
    recursive = true;
    source = pkgs.runCommand "emacs-terminfo" { } ''
      ${pkgs.ncurses}/bin/tic -o $out ${eterm-color}
    '';
  };
}
