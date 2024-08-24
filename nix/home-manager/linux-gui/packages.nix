{pkgs, ...}: {
  home.packages = with pkgs; [
    evince
    maestral-gui
    xsel
    zed-editor

    (muscat.override {useGolangDesign = true;})
  ];
}
