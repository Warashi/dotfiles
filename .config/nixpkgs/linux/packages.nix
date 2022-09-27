{pkgs, ...}: let
  warashiPkgs = import <warashi> {};
in
  with pkgs; [
    deno
    gcc
    sta
    unzip
    zip

    warashiPkgs.muscat
  ]
