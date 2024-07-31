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
  override = epkg: {
    term-title = callPackage ./packages/term-title.nix {
      inherit inputs;
      inherit emacs;
      inherit (epkg) melpaBuild;
    };
    copilot = callPackage ./packages/copilot-el.nix {
      inherit inputs;
      inherit emacs;
      inherit (epkg) melpaBuild dash editorconfig s f jsonrpc;
    };
    org = callPackage ./packages/org.nix {
      inherit emacs;
      inherit (epkg) elpaBuild;
    };
  };
}
