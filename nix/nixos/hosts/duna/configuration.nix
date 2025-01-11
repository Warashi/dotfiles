{
  pkgs,
  ...
}:
{
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp = {
    useTmpfs = true;
  };

  networking.hostName = "duna";

  # Enable networking
  networking.networkmanager.enable = true;
  systemd.network.wait-online.enable = false; # to avoid corruption between networkmanager and systemd-networkd
}
