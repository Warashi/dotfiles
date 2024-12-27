{ pkgs, ... }:
{
  gtk = {
    enable = false;
    font = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Sans JP";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
