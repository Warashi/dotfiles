_: {
  imports = [
    ./overlays.nix

    ./config.nix
    ./packages.nix

    ./catppuccin.nix

    ./alacritty.nix
    ./direnv.nix
    ./files.nix
    ./git.nix
    ./tmux.nix
    ./wezterm.nix

    ./zsh/config.nix
    ./zsh/zcompile-rcs.nix
  ];
}
