{ pkgs, ... }:
let
  custom = [
  ];
  packages = with pkgs; [
    _1password-cli
    bat
    coreutils
    deno
    fd
    ghq
    git-lfs
    gitu
    gnumake
    gnupg
    go_1_23
    htop
    jq
    lefthook
    neovim
    nodejs
    nvfetcher
    oci-cli
    ov
    perl # used by zeno.zsh
    ripgrep
    sheldon
    taplo
    vivid
    yq-go
    zk # makrdown zettelkasten tool
    zstd

    luajitPackages.fennel

    # lanuage server
    buf
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
