{pkgs, ...}: {
  home.packages = with pkgs; [
    _1password
    alacritty
    awscli2
    bat
    carapace
    delta
    deno
    fd
    gh
    ghq
    git
    git-lfs
    glow
    gnumake
    go_1_21
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
    wezterm
    yaskkserv2
    yq-go
    zstd

    python311Packages.pipx

    # lanuage server
    buf-language-server
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
  ];
}
