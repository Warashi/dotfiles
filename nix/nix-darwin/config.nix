{
  self,
  pkgs,
  ...
}: {
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  security = {
    pam = {
      enableSudoTouchIdAuth = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    enableGlobalCompInit = false;
    promptInit = "";
  };

  programs.bash = {
    enable = true;
  };

  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];

  homebrew = {
    enable = true;
    brews = import ./brews.nix;
    casks = import ./casks.nix;
    masApps = import ./mas.nix;
    onActivation = {
      cleanup = "zap";
    };
  };

  nix = {
    gc = {
      automatic = true;
    };
    optimise = {
      automatic = true;
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
