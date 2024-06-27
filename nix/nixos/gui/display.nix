_: {
  services = {
    libinput.enable = true;
    xserver = {
      enable = true;
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
  };
}
