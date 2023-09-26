_: {
  imports = [
    ./nixconfig.nix
    ./locale.nix
    ./tailscale.nix
    ./display.nix
    ./sound.nix
    ./user.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?
}
