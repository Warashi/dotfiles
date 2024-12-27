_: {
  services = {
    libinput.enable = true;
    xserver = {
      enable = true;
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
      };
    };
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
  };
}
