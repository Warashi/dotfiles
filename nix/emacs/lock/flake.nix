{
  description = "THIS IS AN AUTO-GENERATED FILE. PLEASE DON'T EDIT IT MANUALLY.";
  inputs = {
    compat = {
      flake = false;
      owner = "emacs-compat";
      repo = "compat";
      type = "github";
    };
    dash = {
      flake = false;
      owner = "magnars";
      repo = "dash.el";
      type = "github";
    };
    exec-path-from-shell = {
      flake = false;
      owner = "purcell";
      repo = "exec-path-from-shell";
      type = "github";
    };
    git-commit = {
      flake = false;
      owner = "magit";
      repo = "magit";
      type = "github";
    };
    magit = {
      flake = false;
      owner = "magit";
      repo = "magit";
      type = "github";
    };
    magit-nix3 = {
      flake = false;
      owner = "emacs-twist";
      repo = "nix3.el";
      type = "github";
    };
    magit-section = {
      flake = false;
      owner = "magit";
      repo = "magit";
      type = "github";
    };
    nix3 = {
      flake = false;
      owner = "emacs-twist";
      repo = "nix3.el";
      type = "github";
    };
    org = {
      flake = false;
      ref = "bugfix";
      type = "git";
      url = "https://git.savannah.gnu.org/git/emacs/org-mode.git";
    };
    promise = {
      flake = false;
      owner = "chuntaro";
      repo = "emacs-promise";
      type = "github";
    };
    "s" = {
      flake = false;
      owner = "magnars";
      repo = "s.el";
      type = "github";
    };
    twist = {
      flake = false;
      owner = "emacs-twist";
      repo = "twist.el";
      type = "github";
    };
    vterm = {
      flake = false;
      owner = "akermu";
      repo = "emacs-libvterm";
      type = "github";
    };
    with-editor = {
      flake = false;
      owner = "magit";
      repo = "with-editor";
      type = "github";
    };
  };
  outputs = {...}: {};
}
