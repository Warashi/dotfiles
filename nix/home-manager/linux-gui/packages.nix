{pkgs, ...}: {
  home.packages = with pkgs; [
    easyeffects
    firefox
    xsel
    maestral-gui

    (muscat.override {useGolangDesign = true;})
  ];
}
