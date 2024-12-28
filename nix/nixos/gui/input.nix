{
  pkgs,
  inputs,
  ...
}:
{
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons =
          (with pkgs; [
            fcitx5-gtk
            fcitx5-mozc
            kdePackages.fcitx5-qt
          ])
          ++ [
            inputs.fcitx5-hazkey.packages.${pkgs.system}.fcitx5-hazkey
          ];
      };
    };
  };
}
