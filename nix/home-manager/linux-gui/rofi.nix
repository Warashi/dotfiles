{ inputs
, pkgs
, ...
}: {
  xdg.dataFile.catppuccin-rofi = {
    source = inputs.catppuccin-rofi + "/basic/.local/share/rofi/themes";
    target = "rofi/themes";
    recursive = true;
  };

  programs.rofi = {
    enable = true;
    font = "PlemolJP Console NF 18";
    terminal = ''${pkgs.alacritty}/bin/alacritty'';
    theme = "catppuccin-latte";
  };
}
