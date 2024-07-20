{
  emacs,
  pkgs,
  ...
}: let
  emacs' = emacs.package.override {emacs = pkgs.emacs29-pgtk;};
in {
  home.packages = [emacs'];
  services = {
    emacs = {
      enable = true;
      client.enable = true;
      defaultEditor = true;

      package = emacs';
    };
  };
}
