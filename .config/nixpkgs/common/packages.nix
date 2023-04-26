{pkgs}:
with pkgs; [
  _1password
  awscli2
  bat
  bc # https://github.com/NixOS/nixpkgs/issues/225579
  delta
  deno
  exa
  fd
  gh
  ghq
  git
  git-lfs
  glow
  go_1_20
  htop
  hyperfine
  jdk17
  jq
  neovim
  neovim-remote
  nodejs
  python311
  ripgrep
  sheldon
  skim
  tig
  vivid
  yq-go

  python311Packages.pipx

  # neovim から利用
  alejandra
  deadnix
  lua-language-server
  nodePackages.cspell
  selene
  shellcheck
  shellharden
  shfmt
  statix
  stylua
]
