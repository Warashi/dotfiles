{
  home,
  programs,
  pkgs,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./zsh.nix
    ./tmux.nix
  ];

  # home-manager と nix-darwin で同じoverlaysを使うための方策
  nixpkgs.overlays = import ./overlays.nix {inherit pkgs;};

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];

  programs.bash = {
    enable = true;
    initExtra = "exec zsh --login";
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "base16-256";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = ["--color=dark"];
    tmux.enableShellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = ["--cmd j"];
  };
}
