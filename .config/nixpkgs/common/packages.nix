{pkgs}:
with pkgs; [
  awscli2
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

  # null-ls から利用
  alejandra
  deadnix
  selene
  shellcheck
  shellharden
  statix
  stylua
  vale
]
