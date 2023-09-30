{pkgs, ...}: {
  home.packages = with pkgs; [
    dmenu
    rofi
  ];
  xsession = {
    enable = true;
    windowManager = {
      i3 = {
        enable = false;
        config = {
          modifier = "Mod5";
          terminal = "alacritty";
          fonts = {
            names = ["PlemolJP Console NF"];
            style = "Regular";
            size = 18.0;
          };
          gaps = {
            smartBorders = "on";
            smartGaps = true;
            inner = 10;
          };
          window = {
            titlebar = false;
          };
          keybindings = {
            "Mod4+space" = "exec --no-startup-id i3-dmenu-desktop";
            "Control+Shift+Mod1+r" = "restart";
            "Control+Shift+Mod1+e" = "reload";
            "Control+Shift+Mod1+w" = "exit";
          };
        };
      };
    };
  };
}
