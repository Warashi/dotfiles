{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (haskellPackages.ghcWithPackages (hpkgs:
      with hpkgs; [
        xmonad
        xmonad-contrib
      ]))
  ];
  xdg.configFile._1password-gui-autostart = {
    text = ''
      [Desktop Entry]
      Name=1Password
      Type=Application
      Exec=1password --silent
      StartupWMClass=1Password
      Icon=1password
      Comment=Password manager and secure wallet
      Terminal=false
    '';
    target = "autostart/1password-gui.desktop";
  };
  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.feh}/bin/feh --bg-scale ~/Pictures/IMG_0045.png
      ${pkgs.dex}/bin/dex -a
    '';
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.hs;
      };
    };
  };
  services = {
    dunst = {
      enable = true;
      configFile = inputs.catppuccin-dunst + "/src/frappe.conf";
    };
    picom = {
      enable = true;
      activeOpacity = 0.9;
      inactiveOpacity = 0.9;
      menuOpacity = 0.9;
    };
    polybar = {
      enable = true;
      script = "";
      settings = {
        "global/wm" = {
          include-file = inputs.catppuccin-polybar + "/themes/frappe.ini";
        };

        "bar/warashi" = {
          width = "100%";
          height = "24pt";
          radius = 6;

          background = ''''${colors.base}'';
          foreground = ''''${colors.text}'';

          line-size = "3pt";
          border-size = "0pt";
          border-color = ''''${colors.blue}'';

          padding-left = 0;
          padding-right = 1;

          module-margin = 1;

          separator = " | ";
          separator-foreground = ''''${colors.subtext0}'';

          font-0 = "IBM Plex Sans JP";
          font-1 = "PlemolJP Console NF";
          font-2 = "Noto Color Emoji";
          font-3 = "Font Awesome 6 Free";
          font-4 = "monospace;2";

          modules-left = "xworkspaces";
          modules-center = "xwindow";
          modules-right = "filesystem xkeyboard cpu memory swap wlan eth date";

          cursor-click = "pointer";
          cursor-scroll = "ns-resize";

          enable-ipc = true;

          tray-position = "right";

          wm-restack = "generic";
        };

        "module/xworkspaces" = {
          type = "internal/xworkspaces";

          label-active = "%name%";
          label-active-background = ''''${colors.mantle}'';
          label-active-underline = ''''${colors.blue}'';
          label-active-padding = 1;

          label-occupied = "%name%";
          label-occupied-padding = 1;

          label-urgent = "%name%";
          label-urgent-background = ''''${colors.crust}'';
          label-urgent-padding = 1;

          label-empty = "%name%";
          label-empty-foreground = ''''${colors.text}'';
          label-empty-padding = 1;
        };

        "module/xwindow" = {
          type = "internal/xwindow";
          label = "%title:0:60:...%";
        };

        "module/filesystem" = {
          type = "internal/fs";
          interval = 25;

          mount-0 = "/";

          label-mounted = "%{F#F0C674}%mountpoint%%{F-} %percentage_used%%";

          label-unmounted = "%mountpoint% not mounted";
          label-unmounted-foreground = ''''${colors.subtext0}'';
        };

        "module/xkeyboard" = {
          type = "internal/xkeyboard";
          blacklist-0 = "num lock";

          label-layout = "%layout%";
          label-layout-foreground = ''''${colors.text}'';

          label-indicator-padding = 2;
          label-indicator-margin = 1;
          label-indicator-foreground = ''''${colors.text}'';
          label-indicator-background = ''''${colors.blue}'';
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;

          format-prefix = "CPU ";
          format-prefix-foreground = ''''${colors.text}'';

          label = "%percentage:2%%";
        };

        "module/memory" = {
          type = "internal/memory";
          interval = 2;

          format-prefix = "RAM ";
          format-prefix-foreground = ''''${colors.text}'';

          label = "%percentage_used:2%%";
        };

        "module/swap" = {
          type = "internal/memory";
          interval = 2;

          format-prefix = "SWAP ";
          format-prefix-foreground = ''''${colors.text}'';

          label = "%percentage_swap_used:2%%";
        };

        "network-base" = {
          type = "internal/network";
          interval = 5;

          format-connected = "<label-connected>";
          format-disconnected = "<label-disconnected>";

          label-disconnected = "%{F#F0C674}%ifname%%{F#707880} disconnected";
        };

        "module/wlan" = {
          "inherit" = "network-base";
          interface-type = "wireless";
          label-connected = "%{F#F0C674}%ifname%%{F-} %essid% %local_ip%";
        };

        "module/eth" = {
          "inherit" = "network-base";
          interface-type = "wired";
          label-connected = "%{F#F0C674}%ifname%%{F-} %local_ip%";
        };

        "module/date" = {
          type = "internal/date";
          interval = 1;

          date = "%H:%M";
          date-alt = "%Y-%m-%d %H:%M:%S";

          label = "%date%";
          label-foreground = ''''${colors.text}'';
        };

        "settings" = {
          screenchange-reload = true;
          pseudo-transparency = false;
        };
      };
    };
  };
}
