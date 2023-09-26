_: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # we cannot use this with networking.wireless, so this is host config.
  networking.networkmanager.enable = true;

  boot = {
    initrd.availableKernelModules = ["virtiofs"];
    # Bootloader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
}
