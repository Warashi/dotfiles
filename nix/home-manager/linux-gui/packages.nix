{pkgs, ...}: {
  home.packages = with pkgs; [
    xsel
    maestral-gui

    (muscat.override {useGolangDesign = true;})
  ];
}
