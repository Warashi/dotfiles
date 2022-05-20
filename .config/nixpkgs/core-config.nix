{ programs, ... }: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # bash integration
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "viins";

    history = {
      extended = true;
      expireDuplicatesFirst = true;
    };

    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      e = "$EDITOR";
      ls = "exa";
    };
  };

  # direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.skim = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      time.disabled = false;
    };
  };
}
