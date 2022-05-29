{ pkgs }:

let
  warashiPkgs = import <warashi> { };
in

with pkgs; [
  exa
  fd
  gcc
  gh
  ghq
  git
  go_1_18
  htop
  jq
  neovim
  neovim-remote
  ripgrep
  rnix-lsp
  tig

  warashiPkgs.muscat
  warashiPkgs.zabrze
]
