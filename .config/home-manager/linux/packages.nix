{pkgs, ...}: let
  warashiPkgs = import <warashi> {};
in
  with pkgs; [
    gcc
    sta
    unzip
    zip

    warashiPkgs.muscat
  ]
