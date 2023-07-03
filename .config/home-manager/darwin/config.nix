{
  nixpkgs,
  config,
  pkgs,
  ...
}: let
  local = import ../local.nix;
in {
  # import home-manager
  imports = [
    <home-manager/nix-darwin>
  ];

  # home-manager と nix-darwin で同じoverlaysを使うための方策
  nixpkgs.overlays = import ../common/overlays.nix {inherit pkgs;};

  environment.systemPackages = with pkgs; [
    cachix
  ];

  home-manager.useUserPackages = true;

  # user config
  users.users.${local.user} = {
    name = "${local.user}";
    home = "/Users/${local.user}";
    shell = pkgs.zsh;
  };

  home-manager.users.${local.user} = {pkgs, ...}: {
    imports = [
      ../common/config.nix
    ];

    home.sessionVariables = {
      XDG_RUNTIME_DIR = "/Users/${local.user}/.local/run";
      SSH_AUTH_SOCK = "/Users/${local.user}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    home.packages =
      import ./packages.nix {inherit pkgs;}
      ++ import ../common/packages.nix {inherit pkgs;};

    home.file = {
      AquaSKK = {
        source = ./. + "/files/AquaSKK";
        target = "Library/Application Support/AquaSKK";
        recursive = true;
      };
    };

    launchd.agents = {
      muscat = {
        enable = true;
        config = {
          Label = "dev.warashi.muscat";
          ProgramArguments = ["/bin/sh" "-c" "$HOME/.local/bin/muscat server"];
          RunAtLoad = true;
          KeepAlive = true;
        };
      };
    };

    home.stateVersion = "22.05";
  };

  services.autossh.sessions = [
    {
      name = "workbench";
      user = "${local.user}";
      extraArguments = "forward-workbench";
      monitoringPort = 0;
    }
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/home-manager/darwin.nix
  environment.darwinConfig = "$HOME/.config/home-manager/darwin.nix";
  environment.shells = [pkgs.zsh];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
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

  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      NSAutomaticWindowAnimationsEnabled = false;

      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;

      "com.apple.keyboard.fnState" = true;
      "com.apple.springing.enabled" = true;
    };

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

    dock = {
      autohide = true;
      enable-spring-load-actions-on-all-items = true;
      appswitcher-all-displays = true;
      expose-group-by-app = false;
      launchanim = true;
      mineffect = "scale";
      minimize-to-application = true;
      mouse-over-hilite-stack = true;
      mru-spaces = false;
      orientation = "bottom";
      show-process-indicators = true;
      show-recents = false;

      # hot corner actions
      wvous-tl-corner = 1; # disabled
      wvous-tr-corner = 12; # Notification Center
      wvous-bl-corner = 4; # Desktop
      wvous-br-corner = 14; # Quick Note
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXPreferredViewStyle = "Nlsv"; # List view
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    loginwindow = {
      GuestEnabled = false;
    };

    screencapture = {
      disable-shadow = true;
      type = "png";
    };

    spaces = {
      spans-displays = false;
    };

    trackpad = {
      ActuationStrength = 1;
      Clicking = false;
      Dragging = false;
      FirstClickThreshold = 0;
      SecondClickThreshold = 0;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
