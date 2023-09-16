{
  home,
  programs,
  pkgs,
  inputs,
  lib,
  ...
}: {
  nixpkgs.overlays = import ./overlays.nix {inherit pkgs inputs;};

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password-cli"
    ];

  home = {
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/go/bin"
    ];
    packages = import ./packages.nix {inherit pkgs;};
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    bash = {
      enable = true;
      initExtra = "exec zsh --login";
    };

    bat = {
      enable = true;
      config = {
        theme = "Catppuccin-latte";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = false;
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

    fzf = {
      enable = true;
      enableZshIntegration = false;
      defaultOptions = [
        # "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8" # catppuccin-mocha
        "--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39,fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78,marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39" # catppuccin-latte
      ];
      tmux.enableShellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = false;
      options = ["--cmd j"];
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--hidden"
        "--glob=!.git/"
      ];
    };
  };
}
