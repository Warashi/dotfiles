emacs-config: {
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
      earlyInitFile = pkgs.tangleOrgBabelFile "early-init.el" ./early-init.org {};
      createInitFile = true;
      config = emacs-config;
      serviceIntegration.enable = lib.mkDefault false;
      createManifestFile = true;
    };

    home.file = {
      ddskk-config = {
        target = ".local/share/emacs/ddskk/init";
        source = pkgs.tangleOrgBabelFile "ddskk-init.el" ./ddskk.org {};
      };
    };

    # Generate a desktop file for emacsclient
    services.emacs.client.enable = cfg.serviceIntegration.enable;
  };
}
