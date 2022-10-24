{pkgs}: let
  warashiPkgs = import <warashi> {};
in
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
    mosh
    neovim
    ripgrep
    skim
    tig
    yq-go

    warashiPkgs.felix

    # null-ls から利用
    alejandra
    deadnix
    selene
    shellcheck
    shellharden
    shfmt
    statix
    stylua
    vale
  ]
