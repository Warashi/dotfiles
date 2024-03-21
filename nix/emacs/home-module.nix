packages: {
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.emacs-twist;
in {
  config = lib.mkIf cfg.enable {
    programs.emacs-twist = {
      emacsclient.enable = true;
      directory = ".local/share/emacs";
      earlyInitFile = ./early-init.el;
      createInitFile = true;
      config = packages.emacs-config;
      serviceIntegration.enable = lib.mkDefault false;
      createManifestFile = true;
    };

    # Generate a desktop file for emacsclient
    services.emacs.client.enable = cfg.serviceIntegration.enable;
  };
}
