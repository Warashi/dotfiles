_: {
  imports = [
    ./appimage.nix
    ./1password.nix
    ./bluetooth.nix
    ./catppuccin.nix
    ./display.nix
    ./flatpak.nix
    ./fonts.nix
    ./input.nix
    ./keyring.nix
    ./polkit.nix
    ./security.nix
    ./sound.nix
    ./user.nix
    ./xdg.nix
    ./xremap.nix

    ../optional/tailscale.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
