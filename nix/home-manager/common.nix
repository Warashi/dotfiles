_: {
  imports = [
    ./common/overlays.nix

    ./common/config.nix
    ./common/packages.nix

    ./common/alacritty.nix
    ./common/direnv.nix
    ./common/files.nix
    ./common/git.nix
    ./common/tmux.nix
    ./common/lazygit.nix

    ./common/zsh/config.nix
    ./common/zsh/zcompile-rcs.nix
  ];
}
