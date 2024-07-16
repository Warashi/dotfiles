{
  services.openssh = {
    enable = true;
    ports = [64022];
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = ["warashi"];
    };
  };
}
