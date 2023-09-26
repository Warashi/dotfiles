_: {
  console.enable = false;
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager = {
      gdm = {
        enable = true;
      };
    };
    desktopManager = {
      gnome = {
        enable = true;
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
