{
  emacs,
  pkgs,
  ...
}: {
  home.packages = [
    emacs.package
  ];
}
