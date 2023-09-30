{pkgs, ...}: {
  home.packages = with pkgs; [
    (haskellPackages.ghcWithPackages (hpkgs:
      with hpkgs; [
        xmobar
        xmonad
        xmonad-contrib
      ]))
  ];
  xsession = {
    enable = true;
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./config.hs;
      };
    };
  };
}
