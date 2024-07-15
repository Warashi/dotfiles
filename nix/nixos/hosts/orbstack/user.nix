{pkgs, ...}: {
  users = {
    users = {
      warashi = {
        isNormalUser = true;
        linger = true;
        autoSubUidGidRange = true;
        group = "warashi";
        shell = pkgs.bashInteractive;
        extraGroups = [
          "docker"
        ];
      };
    };
    groups = {
      warashi = {};
    };
  };
}
