{
  home,
  programs,
  pkgs,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./files.nix
    ./git.nix
    ./tmux.nix
    ./zsh.nix
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
      theme = "ansi";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    stdlib = ''
      layout_poetry() {
          PYPROJECT_TOML="''${PYPROJECT_TOML:-pyproject.toml}"
          if [[ ! -f "$PYPROJECT_TOML" ]]; then
              log_status "No pyproject.toml found. Executing \`poetry init\` to create a \`$PYPROJECT_TOML\` first."
              poetry init
          fi

          if [[ -d ".venv" ]]; then
              VIRTUAL_ENV="$(pwd)/.venv"
          else
              VIRTUAL_ENV=$(poetry env info --path 2>/dev/null ; true)
          fi

          if [[ -z $VIRTUAL_ENV || ! -d $VIRTUAL_ENV ]]; then
              log_status "No virtual environment exists. Executing \`poetry install\` to create one."
              poetry install
              VIRTUAL_ENV=$(poetry env info --path)
          fi

          PATH_add "$VIRTUAL_ENV/bin"
          export POETRY_ACTIVE=1
          export VIRTUAL_ENV
      }
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = ["--color=light"];
    tmux.enableShellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = ["--cmd j"];
  };
}
