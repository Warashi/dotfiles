{ pkgs, ... }:
let
  custom =
    [
    ];
  packages = with pkgs; [
    _1password-cli
    awscli2
    bat
    coreutils
    deno
    dotnet-sdk_8
    fd
    ghq
    git-lfs
    gitu
    gnumake
    gnupg
    go_1_23
    htop
    jq
    k9s
    kubectl
    kubectx
    kubernetes-helm
    lefthook
    neovim
    nodejs
    oci-cli
    ov
    ripgrep
    sheldon
    taplo
    vivid
    yq-go
    zk # makrdown zettelkasten tool
    zstd

    luajitPackages.fennel

    # lanuage server
    buf-language-server
    efm-langserver
    gopls
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
    nixfmt-rfc-style
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
in
{
  home.packages = custom ++ packages;
}
