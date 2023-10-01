{pkgs, ...}: {
  home.packages = with pkgs; [
    (haskellPackages.ghcWithPackages (hpkgs:
      with hpkgs; [
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
  services.polybar = {
    enable = true;
    script = "";
    settings = {
    };
  };
}
