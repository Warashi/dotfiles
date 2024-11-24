{
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [ ];
    windowrule = [ "pseudo, noblur, class:(fcitx)" ];
    input = {
      repeat_delay = 300;
      repeat_rate = 30;
      follow_mouse = 1;
      sensitivity = lib.mkDefault 0; # -1.0 - 1.0, 0 means no modification.
    };
    general = {
      layout = "master";
      gaps_in = 5;
      gaps_out = 5;
      border_size = 2;
      resize_on_border = true;
    };
    decoration = {
      rounding = 5;
      shadow = {
        enabled = false;
      };
      blur = {
        enabled = false;
      };
      dim_inactive = true;
      dim_strength = 0.1;
    };
    animations = {
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 4, myBezier, slide"
        "layers, 1, 4, myBezier, fade"
        "border, 1, 5, default"
        "fade, 1, 5, default"
        "workspaces, 1, 6, default"
      ];
    };
    misc = {
      disable_hyprland_logo = true;
      vfr = true;
    };
    master = {
      new_status = "master";
      orientation = "right";
    };
  };
}
