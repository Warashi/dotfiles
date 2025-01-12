{ pkgs, lib, ... }:
let
  muscat = pkgs.muscat;
  path = lib.makeBinPath [
    pkgs.xdg-utils
    pkgs.wl-clipboard
  ];
in
{
  systemd.user.services = {
    muscat-server = {
      Unit = {
        Description = "muscat server";
        Documentation = "";
      };
      Service = {
        ExecStart = ''${muscat}/bin/muscat server'';
        Restart = ''always'';
      };
      Environment = {
        PATH = path;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
