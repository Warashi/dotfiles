{pkgs, ...}: {
  xdg = {
    autostart.enable = true;
    icons.enable = true;
    menus.enable = true;
    mime.enable = true;
    portal = {
      enable = true;
      config = {
        common = {
          default = [
            "gtk"
          ];
        };
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    sounds.enable = true;
  };
}
