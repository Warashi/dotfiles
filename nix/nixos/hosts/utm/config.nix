{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # we cannot use this with networking.wireless, so this is host config.
  networking.networkmanager.enable = true;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_5;
    initrd.availableKernelModules = ["virtiofs"];
    # Bootloader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
}
