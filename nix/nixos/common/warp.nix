{pkgs, ...}: let
  rootDir = "/var/lib/cloudflare-warp";
in {
  environment.systemPackages = [pkgs.cloudflare-warp];

  networking.firewall = {
    allowedUDPPorts = [2408];
  };

  systemd.tmpfiles.rules = [
    "d ${rootDir}    - root root"
    "z ${rootDir}    - root root"
    "L /usr/share/warp/images - - - - ${pkgs.cloudflare-warp}/share/warp/images"
  ];

  systemd.services.cloudflare-warp = {
    enable = true;
    description = "Cloudflare Zero Trust Client Daemon";

    # lsof is used by the service to determine which UDP port to bind to
    # in the case that it detects collisions.
    path = [pkgs.lsof];
    requires = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = let
      caps = [
        "CAP_NET_ADMIN"
        "CAP_NET_BIND_SERVICE"
        "CAP_SYS_PTRACE"
      ];
    in {
      Type = "simple";
      ExecStart = "${pkgs.cloudflare-warp}/bin/warp-svc";
      ReadWritePaths = ["${rootDir}" "/etc/resolv.conf"];
      CapabilityBoundingSet = caps;
      AmbientCapabilities = caps;
      Restart = "always";
      RestartSec = 5;
      Environment = ["RUST_BACKTRACE=full"];
      WorkingDirectory = rootDir;

      # See the systemd.exec docs for the canonicalized paths, the service
      # makes use of them for logging, and account state info tracking.
      # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#RuntimeDirectory=
      StateDirectory = "cloudflare-warp";
      RuntimeDirectory = "cloudflare-warp";
      LogsDirectory = "cloudflare-warp";

      # The service needs to write to /etc/resolv.conf to configure DNS, so that file would have to
      # be world read/writable to run as anything other than root.
      User = "root";
      Group = "root";
    };
  };
}
