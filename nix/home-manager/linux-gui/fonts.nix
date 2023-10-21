{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    font-awesome
    ibm-plex
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    plemoljp
  ];
}
