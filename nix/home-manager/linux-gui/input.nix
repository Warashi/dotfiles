{
  pkgs,
  inputs,
  ...
}: {
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons =
          (with pkgs; [
            fcitx5-gtk
            fcitx5-mozc
          ])
          ++ [
            inputs.fcitx5-hazkey.packages.${pkgs.system}.fcitx5-hazkey
          ];
      };
    };
  };
}
