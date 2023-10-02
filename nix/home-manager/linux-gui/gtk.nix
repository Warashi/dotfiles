{pkgs, ...}: {
  gtk = {
    enable = true;
    font = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Sans JP";
    };
    theme = {
      package = pkgs.catppuccin-gtk;
      name = "Catppuccin-Frappe-Standard-Blue-dark";
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    cursorTheme = {
      package = pkgs.catppuccin-cursors.frappeBlue;
      name = "Catppuccin-Frappe-Blue-Cursors";
      size = 24;
    };
  };
}