{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    ...
  }: {
    # Build darwin flake using: darwin-rebuild switch --flake '.#warashi'
    darwinConfigurations."warashi" = nix-darwin.lib.darwinSystem {
      modules = [
        ./config.nix
        ./host.nix
      ];
      specialArgs = {inherit self;};
    };
  };
}
