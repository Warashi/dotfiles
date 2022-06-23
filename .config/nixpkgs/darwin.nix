{ config, pkgs, ... }: {
  # import home-manager
  imports = [
    <home-manager/nix-darwin>
  ];

  # user config
  users.users.sawada = {
    name = "sawada";
    home = "/Users/sawada";
  };
  home-manager.useUserPackages = true;
  home-manager.users.sawada = { pkgs, ... }: {
    home.packages = with pkgs; [ mas ] ++ import ./core-packages.nix { pkgs = pkgs; };
    imports = [ ./core-config.nix ];
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  programs.zsh.enable = true;

  # gpg-agent
  programs.gnupg.agent.enable = true;

  # autossh
  services.autossh.sessions = [{
    name = "workbench";
    user = "sawada";
    extraArguments = "-N forward-workbench";
    monitoringPort = 20000;
  }];

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
    };
    extraConfig = ''
      yabai -m rule --add app=TweetShot manage=off
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

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
