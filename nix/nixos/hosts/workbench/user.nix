{ pkgs, ... }:
{
  users = {
    users = {
      warashi = {
        isNormalUser = true;
        linger = true;
        autoSubUidGidRange = true;
        group = "warashi";
        shell = pkgs.zsh;
        extraGroups = [
          "docker"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/w9P7ws2J3mqoYBFbqcnIPw2idc8NYsoEF/Z3p87DL"
        ];
      };
    };
    groups = {
      warashi = { };
    };
  };
  security.sudo.extraRules = [
    {
      users = [ "warashi" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
