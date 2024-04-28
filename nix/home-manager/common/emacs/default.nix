{pkgs, ...}:
pkgs.emacsWithPackagesFromUsePackage {
  config = ./emacs-config.org;
  defaultInitFile = true;
  alwaysEnsure = false;
  alwaysTangle = true;
}
