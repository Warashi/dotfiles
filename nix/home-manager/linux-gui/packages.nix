{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    muscat
    xsel
  ];
}
