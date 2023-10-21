{pkgs, ...}: {
  home.file.catppuccin-cursor-theme = {
    text = ''
      [icon theme]
      Inherits=Catppuccin-Latte-Blue-Cursors
    '';
    target = ".icons/default/index.theme";
  };
  xresources = {
    properties = {
      "Xcursor.theme" = "Catppuccin-Latte-Blue-Cursors";
      "Xcursor.size" = 24;
    };
  };
  gtk = {
    enable = true;
    font = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Sans JP";
    };
    theme = {
      package = pkgs.catppuccin-gtk;
      name = "Catppuccin-Latte-Standard-Blue-light";
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    cursorTheme = {
      package = pkgs.catppuccin-cursors.latteBlue;
      name = "Catppuccin-Latte-Blue-Cursors";
      size = 24;
    };
  };
}
