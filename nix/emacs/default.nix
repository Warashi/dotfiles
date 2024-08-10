{
  inputs,
  pkgs,
  lib,
  emacsWithPackagesFromUsePackage,
  emacs,
  ...
}:
emacsWithPackagesFromUsePackage {
  package = emacs;
  config = ./emacs-config.org;
  defaultInitFile = true;
  alwaysEnsure = false;
  alwaysTangle = true;
  extraEmacsPackages = epkg:
    with epkg; [
      treesit-grammars.with-all-grammars
    ];
  override = epkgs:
  let callPackage = (lib.callPackageWith (pkgs // epkgs // {inherit inputs emacs;})); in
  {
    term-title = callPackage ./packages/term-title.nix { };
    copilot = callPackage ./packages/copilot-el.nix { };
    org = callPackage ./packages/org.nix { };
    gerbil-mode = callPackage ./packages/gerbil-mode.nix {};
    gambit = callPackage ./packages/gambit.nix {};
    };
}
