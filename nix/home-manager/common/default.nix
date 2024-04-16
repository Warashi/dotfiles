_: {
  imports = [
    ./overlays.nix

    ./config.nix
    ./packages.nix

    ./alacritty.nix
    ./direnv.nix
    ./files.nix
    ./git.nix
    ./tmux.nix

    ./zsh/config.nix
    ./zsh/zcompile-rcs.nix
  ];
}
