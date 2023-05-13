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
  gauche
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
  tmux-xpanes
  vivid
  yq-go
  zig

  python311Packages.pipx

  # lanuage server
  gopls
  lua-language-server
  terraform-ls
  zls

  # null-ls から利用
  alejandra
  deadnix
  nodePackages.cspell
  selene
  shellcheck
  shellharden
  shfmt
  statix
  stylua
]
