{
  inputs,
  pkgs,
  ...
}:
pkgs.emacsWithPackagesFromUsePackage {
  package = pkgs.emacs-nox;
  config = ./emacs-config.org;
  defaultInitFile = true;
  alwaysEnsure = false;
  alwaysTangle = true;
  extraEmacsPackages = epkg: with epkg; [
    treesit-grammars.with-all-grammars
  ];
  override = epkg:
    epkg
    // {
      copilot = pkgs.callPackage ./copilot-el.nix {
        inherit inputs;
        inherit (epkg) melpaBuild dash editorconfig s f jsonrpc;
        inherit (pkgs) lib nodejs;
      };
    };
}
