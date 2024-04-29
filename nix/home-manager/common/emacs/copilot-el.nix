{
  inputs,
  lib,
  writeText,
  melpaBuild,
  nodejs,
  dash,
  editorconfig,
  jsonrpc,
  s,
  f,
  ...
}:
melpaBuild {
  pname = "copilot";
  version = inputs.emacs-copilot.lastModifiedDate;
  src = inputs.emacs-copilot;
  commit = inputs.emacs-copilot.rev;
  recipe = writeText "recipe" ''
    (copilot :repo "copilot-emacs/copilot.el" :fetcher github)
  '';

  packageRequires = [
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
