{
  callPackage,
  lib,
  writeText,
  melpaBuild,
  emacs,
  ...
}:
let
  generated = callPackage ../_sources/generated.nix { };
in
melpaBuild {
  pname = "term-title";
  version = "0.0.1";
  src = generated.emacs-term-title.src;
  commit = generated.emacs-term-title.version;
  recipe = writeText "recipe" ''
    (term-title :repo "CyberShadow/term-title" :fetcher github)
  '';

  packageRequires = [
    emacs
  ];
  buildInputs = [
  ];
  meta = {
    homepage = "https://github.com/CyberShadow/term-title";
    platforms = lib.platforms.unix;
  };
}
