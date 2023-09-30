{pkgs, ...}: {
  home.packages = with pkgs; [
    dmenu
  ];
  xsession = {
    enable = true;
    windowManager = {
      i3 = {
        enable = true;
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
            "Mod1+space" = "exec --no-startup-id i3-dmenu-desktop";
            "Control+Shift+Mod1+r" = "restart";
            "Control+Shift+Mod1+e" = "reload";
            "Control+Shift+Mod1+w" = "exit";
          };
        };
      };
    };
  };
}
