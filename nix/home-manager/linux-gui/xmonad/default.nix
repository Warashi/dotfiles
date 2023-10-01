{pkgs, ...}: {
  home.packages = with pkgs; [
    haskellPackages.xmobar

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

  xdg.configFile.xmobar = {
    source = ./xmobar.hs;
    target = "xmobar/xmobar.hs";
    onChange = "rm -f ~/.config/xmobar/xmobar ~/.config/xmobar/xmobar.o ~/.config/xmobar/xmobar.hi"; # xmobar.hs のタイムスタンプがepoch timeになるので、手動で消す
  };
}
