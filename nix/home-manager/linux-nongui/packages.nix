{pkgs, ...}: {
  home.packages = with pkgs; [
    muscat
  ];
}
