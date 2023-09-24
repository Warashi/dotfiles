_: {
  imports = [
    ./hardware-configuration.nix
  ];

  # we cannot use this with networking.wireless, so this is host config.
  networking.networkmanager.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
}
