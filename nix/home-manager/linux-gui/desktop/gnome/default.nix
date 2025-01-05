{ pkgs, ... }:
{
  home = {
    packages = with pkgs.gnomeExtensions; [
      xremap
      kimpanel
    ];
  };
  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        status-icons.extensionUuid
        xremap.extensionUuid
        kimpanel.extensionUuid
      ];
    };
  };
}
