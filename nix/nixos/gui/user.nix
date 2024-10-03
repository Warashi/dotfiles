{ pkgs, ... }:
{
  users = {
    users = {
      warashi = {
        isNormalUser = true;
        linger = true;
        autoSubUidGidRange = true;
        description = "warashi";
        group = "warashi";
        shell = pkgs.bashInteractive;
        extraGroups = [
          "docker"
          "networkmanager"
          "wheel"
        ];
      };
    };
    groups = {
      warashi = { };
    };
  };
}
