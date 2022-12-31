{pkgs}:
with pkgs; [
  _1password
  awscli2
  bat
  delta
  deno
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
  nap
  neovim
  ripgrep
  skim
  tig
  yq-go
  zk

  python310Packages.pipx

  # null-ls から利用
  alejandra
  deadnix
  selene
  shellcheck
  shellharden
  shfmt
  statix
  stylua
]
