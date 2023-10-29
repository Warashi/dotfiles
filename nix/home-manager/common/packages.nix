{pkgs, ...}: {
  home.packages = with pkgs; [
    _1password
    aria
    awscli2
    bat
    delta
    deno
    devbox
    fd
    ghq
    git-lfs
    glow
    gnumake
    go
    htop
    hyperfine
    jq
    kubectl
    kubectx
    lazygit
    lefthook
    mocword
    mocword-data
    neovim
    neovim-remote
    nodejs
    ripgrep
    sheldon
    taplo
    tig
    tmux-mvr
    tmux-xpanes
    vivid
    yaskkserv2
    yq-go
    zk # makrdown zettelkasten tool
    zstd

    luajitPackages.fennel

    # lanuage server
    buf-language-server
    efm-langserver
    fennel-language-server
    haskell-language-server
    lua-language-server
    marksman # markdown language server
    nil # nix language server
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
}
