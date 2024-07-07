{inputs, pkgs, ...}:{
  imports = [
    ./settings.nix
    ./keybinds.nix
    ./wofi.nix
    ./swaylock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      variables = ["--all"];
    };
  };

  home.packages = (with pkgs; [
      brightnessctl # screen brightness
      grimblast # screenshot
      hyprpicker # color picker
      pamixer # pulseaudio mixer
      playerctl # media player control
      swww # wallpaper
      wev # key event watcher
      wf-recorder # screen recorder
      wl-clipboard # clipboard manager
  ])
  ++ [
    inputs.hyprsome.packages.${pkgs.system}.default
  ];
}
