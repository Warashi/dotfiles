_: {
  imports = [
    ./1password.nix
    ./display.nix
    ./fonts.nix
    ./keyring.nix
    ./polkit.nix
    ./security.nix
    ./sound.nix
    ./user.nix
    ./xdg.nix
    ./xremap.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
