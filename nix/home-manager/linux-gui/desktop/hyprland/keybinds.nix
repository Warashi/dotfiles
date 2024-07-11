{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SHIFT CTRL ALT";
    "$subMod" = "SUPER";
    "$term" = "alacritty";
    bind = [
      "$mainMod, Return, exec, $term"
      "$mainMod SUPER, Q, killactive"
      "$mainMod SUPER, M, exit"
      "$mainMod, F, fullscreen"
      "$mainMod SUPER, F, togglefloating"

      # move focus
      "$mainMod, h, movefocus, l"
      "$mainMod, j, movefocus, d"
      "$mainMod, k, movefocus, u"
      "$mainMod, l, movefocus, r"
      "$subMod, Tab, layoutmsg, cyclenext"
      "$subMod SHIFT, Tab, layoutmsg, cycleprev"

      # move window
      "$mainMod, m, layoutmsg, swapwithmaster"

      # switch workspace
      "$mainMod, 1, exec, hyprsome workspace 1"
      "$mainMod, 2, exec, hyprsome workspace 2"
      "$mainMod, 3, exec, hyprsome workspace 3"
      "$mainMod, 4, exec, hyprsome workspace 4"
      "$mainMod, 5, exec, hyprsome workspace 5"
      "$mainMod, 6, exec, hyprsome workspace 6"
      "$mainMod, 7, exec, hyprsome workspace 7"
      "$mainMod, 8, exec, hyprsome workspace 8"
      "$mainMod, 9, exec, hyprsome workspace 9"
      "$mainMod, 0, exec, hyprsome workspace 10"
      "$mainMod, right, workspace, r+1"
      "$mainMod, left, workspace, r-1"

      # move window to workspace
      "$mainMod SUPER, 1, exec, hyprsome move 1"
      "$mainMod SUPER, 2, exec, hyprsome move 2"
      "$mainMod SUPER, 3, exec, hyprsome move 3"
      "$mainMod SUPER, 4, exec, hyprsome move 4"
      "$mainMod SUPER, 5, exec, hyprsome move 5"
      "$mainMod SUPER, 6, exec, hyprsome move 6"
      "$mainMod SUPER, 7, exec, hyprsome move 7"
      "$mainMod SUPER, 8, exec, hyprsome move 8"
      "$mainMod SUPER, 9, exec, hyprsome move 9"
      "$mainMod SUPER, 0, exec, hyprsome move 10"
      "$mainMod SUPER, right, movetoworkspace, r+1"
      "$mainMod SUPER, left, movetoworkspace, r-1"

      # screenshot
      ", Print, exec, grimblast --notify copy output"
      ''$mainMod, Print, exec, grimblast --notify copysave output "$HOME/Screenshots/$(date +%Y-%m-%dT%H:%M:%S).png"''
      ''$mainMod SUPER, s, exec, grimblast --notify copysave area "$HOME/Screenshots/$(date +%Y-%m-%dT%H:%M:%S).png"''

      # launcher
      "$mainMod, s, exec, wofi --show drun --width 512px"
      "$mainMod, period, exec, wofi-emoji"

      # color picker
      "$mainMod SUPER, c, exec, hyprpicker --autocopy"

      # screen lock
      "$mainMod SUPER, l, exec, hyprlock"

      # system
      "$mainMod, x, exec, systemctl suspend"
    ];
    bindm = [
      # move/resize window
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
    bindl = [
      # media control
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume control: mute
      ", XF86AudioMute, exec, pamixer -t"
    ];
    bindle = [
      # volume control
      ", XF86AudioRaiseVolume, exec, pamixer -i 10"
      ", XF86AudioLowerVolume, exec, pamixer -d 10"

      # brightness control
      ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ];
  };
}
