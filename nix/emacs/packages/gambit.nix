{
  gerbil,
  lib,
  writeText,
  melpaBuild,
  emacs,
  ...
}:
melpaBuild {
  pname = "gambit";
  version = gerbil.version;
  src = gerbil.outPath + "/gerbil//share/emacs/site-lisp";
  recipe = writeText "recipe" ''
    (gambit :fetcher github :repo "gambit/gambit" :files ("gambit.el"))
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
