{ pkgs, ... }:
{
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
            "kde"
          ];
        };
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.kdePackages.xdg-desktop-portal-kde
      ];
    };
    sounds.enable = true;
  };
}
