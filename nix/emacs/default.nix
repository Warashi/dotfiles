{
  inputs,
  pkgs,
  ...
}:
pkgs.emacsWithPackagesFromUsePackage {
  config = ./emacs-config.org;
  defaultInitFile = true;
  alwaysEnsure = false;
  alwaysTangle = true;
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
