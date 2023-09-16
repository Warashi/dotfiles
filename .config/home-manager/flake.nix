{
  description = "Home Manager configuration of sawada";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    local = import ./local.nix;
    inherit (local) system;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.${local.user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules =
        [
          ./common/config.nix
          ./common/alacritty.nix
          ./common/files.nix
          ./common/git.nix
          ./common/tmux.nix
          ./common/zsh.nix
        ]
        ++ (
          if local.isDarwin
          then [./darwin/config.nix]
          else [./linux/config.nix]
        );

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
