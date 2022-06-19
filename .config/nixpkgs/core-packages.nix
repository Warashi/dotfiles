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
  git-lfs
  go_1_18
  htop
  jq
  mosh
  neovim
  neovim-remote
  ripgrep
  rnix-lsp
  tig

  warashiPkgs.zabrze
]
