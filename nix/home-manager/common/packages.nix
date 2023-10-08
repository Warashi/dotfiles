{ pkgs, ... }: {
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
    go_1_21
    htop
    hyperfine
    jq
    kubectl
    kubectx
    lazygit
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
    zstd

    # lanuage server
    buf-language-server
    haskell-language-server
    lua-language-server
    nil # nix language server
    nodePackages_latest.typescript-language-server
    nodePackages_latest.yaml-language-server
    terraform-ls

    # formatter, linter
    alejandra
    beautysh
    deadnix
    nixpkgs-fmt
    nodePackages.cspell
    selene
    shellcheck
    shellharden
    shfmt
    statix
    stylua
  ];
}
