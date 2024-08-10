{
  gerbil,
  lib,
  writeText,
  melpaBuild,
  emacs,
  ...
}:
melpaBuild {
  pname = "gerbil-mode";
  version = gerbil.version;
  src = gerbil.outPath + "/gerbil//share/emacs/site-lisp";
  recipe = writeText "recipe" ''
    (gerbil-mode :fetcher github :repo "mighty-gerbils/gerbil" :files ("gerbil-mode.el"))
  '';

  doUnpack = false;

  packageRequires = [
    emacs
  ];
  meta = {
    homepage = "https://github.com/copilot-emacs/copilot.el";
    platforms = lib.platforms.unix;
  };
}
