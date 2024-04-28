{
  home,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    emacs-macport
  ];
}
