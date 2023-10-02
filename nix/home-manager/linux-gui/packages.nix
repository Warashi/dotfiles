{pkgs, ...}: {
  home.packages = with pkgs; [
    easyeffects
    firefox
    muscat
    xsel
  ];
}
