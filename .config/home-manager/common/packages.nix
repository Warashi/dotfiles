{pkgs, ...}:
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
  gnumake
  go
  htop
  hyperfine
  jdk17
  jq
  kubectl
  kubectx
  mocword
  mocword-data
  neovim
  neovim-remote
  nodejs
  okteto
  python311
  ripgrep
  sheldon
  taplo
  tig
  tmux-mvr
  tmux-xpanes
  vivid
  yq-go
  zstd

  python311Packages.pipx

  # lanuage server
  buf-language-server
  gopls
  lua-language-server
  nodePackages_latest.typescript-language-server
  nodePackages_latest.yaml-language-server
  terraform-ls

  # null-ls から利用
  alejandra
  beautysh
  deadnix
  nodePackages.cspell
  selene
  shellcheck
  shellharden
  shfmt
  statix
  stylua
]
