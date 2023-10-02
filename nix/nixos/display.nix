_: {
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager = {
      gdm = {
        enable = true;
      };
      session = [
        {
          manage = "window";
          name = "xmonad";
          start = "";
        }
      ];
    };
  };
}
