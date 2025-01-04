{ pkgs, ... }:
{
  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        xremap.extensionUuid
        kimpanel.extensionUuid
      ];
    };
  };
}
