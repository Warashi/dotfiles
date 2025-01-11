{
  pkgs,
  ...
}:
{
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp = {
    useTmpfs = true;
  };

  networking.hostName = "workbench";

  # Enable networking
  networking.networkmanager.enable = true;
}
