_: {
  imports = [
    ./1password.nix
    ./display.nix
    ./keyring.nix
    ./locale.nix
    ./nixconfig.nix
    ./polkit.nix
    ./security.nix
    ./sound.nix
    ./tailscale.nix
    ./user.nix
    ./xdg.nix
    ./xremap.nix
    ./zramswap.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?
}
