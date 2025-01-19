{
  callPackage,
  lib,
  writeText,
  melpaBuild,
  nodejs,
  emacs,
  dash,
  editorconfig,
  jsonrpc,
  s,
  f,
  ...
}:
let
  generated = callPackage ../_sources/generated.nix { };
in
melpaBuild {
  pname = "copilot";
  version = "0.0.1";
  src = generated.emacs-copilot.src;
  commit = generated.emacs-copilot.version;
  recipe = writeText "recipe" ''
    (copilot :repo "copilot-emacs/copilot.el" :fetcher github)
  '';

  packageRequires = [
    emacs

    dash
    editorconfig
    jsonrpc
    s
    f
  ];
  buildInputs = [
    nodejs
  ];
  meta = {
    homepage = "https://github.com/copilot-emacs/copilot.el";
    platforms = lib.platforms.unix;
  };
}
