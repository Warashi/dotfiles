{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./keybinds.nix
    ./settings.nix

    ./mako.nix
    ./waybar.nix
    ./wofi.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      variables = [ "--all" ];
      enableXdgAutostart = true;
    };
  };

  home.packages =
    (with pkgs; [
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
