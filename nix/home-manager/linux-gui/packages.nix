{pkgs, ...}: {
  home.packages = with pkgs; [
    easyeffects
    microsoft-edge
    xsel

    (muscat {useGolangDesign = true;})
  ];
}
