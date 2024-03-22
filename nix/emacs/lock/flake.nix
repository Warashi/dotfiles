{
  description = "THIS IS AN AUTO-GENERATED FILE. PLEASE DON'T EDIT IT MANUALLY.";
  inputs = {
    exec-path-from-shell = {
      flake = false;
      owner = "purcell";
      repo = "exec-path-from-shell";
      type = "github";
    };
    org = {
      flake = false;
      ref = "bugfix";
      type = "git";
      url = "https://git.savannah.gnu.org/git/emacs/org-mode.git";
    };
    vterm = {
      flake = false;
      owner = "akermu";
      repo = "emacs-libvterm";
      type = "github";
    };
  };
  outputs = {...}: {};
}
