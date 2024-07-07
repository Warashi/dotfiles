{pkgs, ...}: {
  home.packages = with pkgs; [ 
    swaylock-effects
  ];
}
