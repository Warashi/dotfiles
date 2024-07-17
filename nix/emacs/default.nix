{
  inputs,
  callPackage,
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
  override = epkg:
    epkg
    // {
      copilot = callPackage ./copilot-el.nix {
        inherit inputs;
        inherit (epkg) melpaBuild dash editorconfig s f jsonrpc;
      };
    };
}
