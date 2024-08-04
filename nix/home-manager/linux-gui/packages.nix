{pkgs, ...}: {
  home.packages = with pkgs; [
    evince
    maestral-gui
    xsel

    (muscat.override {useGolangDesign = true;})
  ];
}
