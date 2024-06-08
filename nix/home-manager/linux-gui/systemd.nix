{pkgs, ...}: let
  muscat = pkgs.muscat.override {useGolangDesign = true;};
in {
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
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
