_: {
  imports = [
    ./locale.nix
    ./nix-ld.nix
    ./nixconfig.nix
    ./warp.nix
    ./zramswap.nix
    ./zsh.nix
  ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
