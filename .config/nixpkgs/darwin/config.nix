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
  nixpkgs.overlays = import ../common/overlays.nix;

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

    home.sessionVariables.SSH_AUTH_SOCK = "/Users/${local.user}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";

    home.packages =
      import ./packages.nix {inherit pkgs;}
      ++ import ../common/packages.nix {inherit pkgs;};

    home.stateVersion = "22.05";
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin.nix";
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
    cleanup = "zap";
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    config = {
      focus_follows_mouse = "off";
      mouse_follows_focus = "off";
      window_origin_display = "default";
      window_placement = "second_child";
      window_opacity = "off";
      window_topmost = "off";
      window_shadow = "on";
      active_window_opacity = "1.0";
      normal_window_opacity = "0.9";
      split_ratio = "0.50";
      auto_balance = "on";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      window_gap = 6;
      external_bar = "all:26:0";
    };
    extraConfig = ''
      yabai -m rule --add app='Cisco AnyConnect Secure Mobility Client' manage=off
      yabai -m rule --add app='Discord' title='Discord Updater' manage=off
      yabai -m rule --add app='JetBrains Toolbox' manage=off
      yabai -m rule --add app='Timemator' title='Timemator' manage=off
      yabai -m rule --add app='TweetShot' manage=off
      yabai -m rule --add app='システム環境設定' manage=off
      yabai -m rule --add title='ピクチャ イン ピクチャ' manage=off
    '';
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # focus window
      shift + ctrl + alt - h : yabai -m window --focus west  || yabai -m display --focus west
      shift + ctrl + alt - j : yabai -m window --focus south || yabai -m display --focus south
      shift + ctrl + alt - k : yabai -m window --focus north || yabai -m display --focus north
      shift + ctrl + alt - l : yabai -m window --focus east  || yabai -m display --focus east
      # swap window
      cmd + shift + ctrl + alt - h : yabai -m window --swap west  || ( yabai -m window --display west  && yabai -m display --focus west )
      cmd + shift + ctrl + alt - j : yabai -m window --swap south || ( yabai -m window --display south && yabai -m display --focus south)
      cmd + shift + ctrl + alt - k : yabai -m window --swap north || ( yabai -m window --display north && yabai -m display --focus north)
      cmd + shift + ctrl + alt - l : yabai -m window --swap east  || ( yabai -m window --display east  && yabai -m display --focus east )
      # rotate tree
      shift + ctrl + alt - r : yabai -m space --rotate 90
      # toggle window fullscreen zoom
      shift + ctrl + alt - f : yabai -m window --toggle zoom-fullscreen
      # toggle window split type
      shift + ctrl + alt - e : yabai -m window --toggle split
      # minimize window
      shift + ctrl + alt - m : yabai -m window --minimize
    '';
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      position = "top";
      display = "all";
      height = 26;
      title = "on";
      spaces = "off";
      clock = "on";
      power = "on";
      padding_left = 20;
      padding_right = 20;
      spacing_left = 25;
      spacing_right = 15;
      text_font = ''"UDEV Gothic 35JPDOC:Regular:12.0"'';
      icon_font = ''"Font Awesome 6 Free:Solid:12.0"'';
      background_color = "0xff202020";
      foreground_color = "0xffa8a8a8";
      power_icon_color = "0xffcd950c";
      battery_icon_color = "0xffd75f5f";
      dnd_icon_color = "0xffa8a8a8";
      clock_icon_color = "0xffa8a8a8";
      power_icon_strip = " ";
      display_separator = "on";
      display_separator_icon = "";
      clock_icon = "";
      dnd_icon = "";
      clock_format = ''"%y/%m/%d %R"'';
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

      _HIHideMenuBar = true;

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
      orientation = "left";
      show-process-indicators = true;
      show-recents = false;

      # hot corner actions
      wvous-bl-corner = 2; # mission control
      wvous-br-corner = 3; # application windows
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
