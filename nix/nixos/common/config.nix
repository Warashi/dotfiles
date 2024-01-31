_: {
  imports = [
    ./locale.nix
    ./nixconfig.nix
    ./tailscale.nix
    ./zramswap.nix
  ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
