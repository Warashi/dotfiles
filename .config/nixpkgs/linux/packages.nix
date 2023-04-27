{pkgs, ...}: let
  warashiPkgs = import <warashi> {};
in
  with pkgs; [
    gcc
    sta
    unzip
    vscode
    zip

    warashiPkgs.muscat
  ]
