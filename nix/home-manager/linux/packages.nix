{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    maestral
    psmisc
    sta
    unzip
    zip
  ];
}
