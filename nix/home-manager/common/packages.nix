{pkgs, ...}: let
  custom = [
  ];
  packages = with pkgs; [
    _1password
    awscli2
    bat
    coreutils
    deno
    devbox
    fd
    ghq
    git-lfs
    gitu
    gnumake
    gnupg
    go
    guile
    htop
    hyperfine
    jq
    k9s
    kubectl
    kubectx
    kubernetes-helm
    lefthook
    mocword
    mocword-data
    neovim
    neovim-remote
    nodejs
    oci-cli
    ov
    ripgrep
    rye
    sheldon
    taplo
    tmux-mvr
    tmux-xpanes
    vivid
    yq-go
    zk # makrdown zettelkasten tool
    zstd

    luajitPackages.fennel

    # lanuage server
    buf-language-server
    efm-langserver
    gopls
    haskell-language-server
    lua-language-server
    marksman # markdown language server
    nixd # nix language server
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vim-language-server
    nodePackages_latest.yaml-language-server
    terraform-ls

    # formatter, linter
    ## shell
    beautysh
    shellcheck
    shellharden

    ## nix
    alejandra
    deadnix
    statix

    ## lua
    selene
    stylua

    ## fennel
    fnlfmt

    ## spelling
    nodePackages_latest.cspell
  ];
in {
  home.packages = custom ++ packages;
}
