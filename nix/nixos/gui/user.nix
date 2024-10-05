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
        shell = pkgs.zsh;
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
