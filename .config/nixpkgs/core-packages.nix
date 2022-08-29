{ pkgs }:

let
  warashiPkgs = import <warashi> { };
in

with pkgs; [
  bat
  delta
  exa
  fd
  gh
  ghq
  git
  git-lfs
  glow
  go_1_19
  htop
  jq
  mosh
  neovim
  ripgrep
  skim
  tig
  yq-go
]
