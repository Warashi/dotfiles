{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (ghc.withPackages (hpkgs:
      with hpkgs; [
        taffybar

        xmonad
        xmonad-contrib
        xmonad-extras
      ]))
  ];
  xdg = {
    configFile = {
      taffybar = {
        source = ./taffybar.hs;
        target = "taffybar/taffybar.hs";
        onChange = "rm -rf ~/.cache/taffybar"; # nix で作成されるファイルは timestamp が epoch time なので、変更検知が効かない。そのため、ビルド済みのバイナリを手動で削除する。
      };
    };
  };
  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.feh}/bin/feh --bg-fill ~/Pictures/IMG_0045.png
      ${pkgs.dex}/bin/dex -a
    '';
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.hs;
      };
    };
  };
  services = {
    dunst = {
      enable = true;
      configFile = inputs.catppuccin-dunst + "/src/latte.conf";
    };
    picom = {
      enable = true;
      activeOpacity = 0.9;
      inactiveOpacity = 0.9;
      menuOpacity = 0.9;
    };
    status-notifier-watcher = {
      enable = true;
    };
    taffybar = {
      enable = true;
    };
  };
}
