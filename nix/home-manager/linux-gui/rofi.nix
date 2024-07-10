{
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    font = "PlemolJP Console NF 18";
    terminal = ''${pkgs.alacritty}/bin/alacritty'';
  };
}
