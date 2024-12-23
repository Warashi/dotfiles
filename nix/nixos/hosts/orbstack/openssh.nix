{ lib, ... }:
{
  programs.ssh.setXAuthLocation = lib.mkForce true;
  services.openssh = {
    enable = true;
    ports = [ 64022 ];
    settings = {
      StreamLocalBindUnlink = true;
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = [ "warashi" ];
    };
    extraConfig = ''
      AcceptEnv COLORTERM
    '';
  };
}
