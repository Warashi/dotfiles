{pkgs, ...}: let
  warashiPkgs = import <warashi> {};
in
  with pkgs; [
    deno
    sta
    unzip

    warashiPkgs.muscat
  ]
