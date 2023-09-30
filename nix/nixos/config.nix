_: {
  imports = [
    ./display.nix
    ./locale.nix
    ./nixconfig.nix
    ./security.nix
    ./sound.nix
    ./tailscale.nix
    ./user.nix
    ./xremap.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?
}
