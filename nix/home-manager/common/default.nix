_: {
  imports = [
    ./overlays.nix

    ./nix.nix
    ./config.nix
    ./packages.nix

    ./catppuccin.nix

    ./alacritty.nix
    ./direnv.nix
    ./files.nix
    ./git.nix
    ./tmux.nix

    ./zsh/config.nix
    ./zsh/zcompile-rcs.nix

    ../../emacs/terminfo.nix
  ];
}
