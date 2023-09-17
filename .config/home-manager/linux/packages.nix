{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    sta
    unzip
    zip
    muscat
  ];
}
