{ pkgs, ... }:
{
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    size = 32;
    package = pkgs.vanilla-dmz;
    gtk = {
      enable = true;
    };
    hyprcursor = {
      enable = true;
      size = 32;
    };
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };
}
