{ pkgs }:

let
  warashiPkgs = import <warashi> { };
in

with pkgs; [
  bat
  delta
  deno
  exa
  fd
  gcc
  gh
  ghq
  git
  git-lfs
  glow
  go_1_18
  htop
  jq
  mosh
  neovim
  neovim-remote
  ripgrep
  rnix-lsp
  skim
  tig
  yq-go

  warashiPkgs.zabrze
]
