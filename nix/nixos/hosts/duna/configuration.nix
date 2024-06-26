# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-dfd4716d-98d2-4dcf-a10e-455bfc88e8ef".device = "/dev/disk/by-uuid/dfd4716d-98d2-4dcf-a10e-455bfc88e8ef";
  networking.hostName = "duna";

  # Enable networking
  networking.networkmanager.enable = true;
}
