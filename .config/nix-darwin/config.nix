{self, ...}: {
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    promptInit = "";
  };

  homebrew = {
    enable = true;
    brews = import ./brews.nix;
    casks = import ./casks.nix;
    masApps = import ./mas.nix;
    onActivation = {
      cleanup = "zap";
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
