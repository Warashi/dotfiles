{pkgs, ...}: {
  home.packages = with pkgs; [
    easyeffects
    firefox
    xsel

    (muscat.override {useGolangDesign = true;})
  ];
}
