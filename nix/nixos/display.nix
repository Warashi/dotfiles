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
    windowManager = {
      i3 = {
        enable = true;
      };
    };
  };
}
