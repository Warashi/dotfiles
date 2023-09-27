{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # we cannot use this with networking.wireless, so this is host config.
  networking.networkmanager.enable = true;

  boot = {
    # Bootloader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "parallels"; # Define your hostname.
}
