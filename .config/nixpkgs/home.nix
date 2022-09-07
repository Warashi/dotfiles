{ config, pkgs, home, ... }:
let
  warashiPkgs = import <warashi> { };
in
{
  imports = [
    ./local.nix
    ./core-config.nix
  ];

  nixpkgs.overlays = import ./overlays.nix;

  home.packages = with pkgs; [
    deno
    sta
    unzip

    warashiPkgs.muscat
  ]
  ++ import ./core-packages.nix { pkgs = pkgs; };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
