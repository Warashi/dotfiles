{ pkgs, ... }: {
  home.packages = with pkgs; [
    easyeffects
    firefox
    xsel

    (muscat { useGolangDesign = true; })
  ];
}
