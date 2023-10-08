{ pkgs, ... }: {
  home.packages = with pkgs; [
    gcc
    psmisc
    sta
    unzip
    zip
  ];
}
