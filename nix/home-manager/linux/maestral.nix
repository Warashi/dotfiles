{pkgs,...}: {
systemd.user.services.maestral = {
    Unit.Description = "Maestral daemon";
    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
      ExecStop = "${pkgs.maestral}/bin/maestral stop";
      Restart = "on-failure";
      Nice = 10;
    };
  };
}
