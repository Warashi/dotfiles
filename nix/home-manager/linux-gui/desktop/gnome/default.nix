{ pkgs, lib, ... }:
{
  programs = {
    bash = {
      enable = lib.mkForce false; # to avoid loading session variables from gnome-session
    };
  };
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
