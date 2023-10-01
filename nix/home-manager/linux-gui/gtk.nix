{pkgs, ...}: {
  gtk = {
    enable = true;
    font = {
      package = pkgs.plemoljp;
      name = "PlemolJP Console NF";
      size = 16;
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
