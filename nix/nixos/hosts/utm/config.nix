_: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.initrd.availableKernelModules = [ "virtiofs" ];

  # we cannot use this with networking.wireless, so this is host config.
  networking.networkmanager.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
}
