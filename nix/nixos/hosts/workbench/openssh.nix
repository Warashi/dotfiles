{
  services.openssh = {
    enable = true;
    settings = {
      StreamLocalBindUnlink = true;
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
