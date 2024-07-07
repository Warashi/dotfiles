_: {
  programs.hyprland.enable = true;
  services = {
    libinput.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
        };
      };
    };
  };
}
