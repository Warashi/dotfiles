{
  inputs,
  lib,
  writeText,
  melpaBuild,
  emacs,
  ...
}:
melpaBuild {
  pname = "term-title";
  version = inputs.emacs-term-title.lastModifiedDate;
  src = inputs.emacs-term-title;
  commit = inputs.emacs-term-title.rev;
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
