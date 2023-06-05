{pkgs, ...}: let
  warashiPkgs = import <warashi> {};
in
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
    gnumake
    go_1_20
    htop
    hyperfine
    jdk17
    jq
    kubectl
    kubectx
    neovim
    neovim-remote
    nodejs
    okteto
    python311
    ripgrep
    sheldon
    taplo
    tig
    tmux-xpanes
    vivid
    yq-go
    zstd

    warashiPkgs.tmux-mvr
    warashiPkgs.mocword
    warashiPkgs.mocword-data

    python311Packages.pipx

    # lanuage server
    gopls
    lua-language-server
    nodePackages_latest.typescript-language-server
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
