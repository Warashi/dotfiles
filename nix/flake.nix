{
  description = "Home Manager configuration of sawada";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        neovim-flake.follows = "neovim-flake";
      };
    };
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    skk-jisyo-L = {
      url = "github:skk-dev/dict";
      flake = false;
    };
    skk-jisyo-jawiki = {
      url = "github:tokuhirom/jawiki-kana-kanji-dict";
      flake = false;
    };
    bat-catppuccin-latte = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-zsh-fsh = {
      url = "github:catppuccin/zsh-fsh?dir=themes";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  }: {
    darwinConfigurations = {
      warashi = nix-darwin.lib.darwinSystem {
        modules = [
          ./nix-darwin/host.nix
          ./nix-darwin/config.nix
        ];
        specialArgs = {inherit self;};
      };
    };
    homeConfigurations = {
      warashi = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;

        modules = [
          ./home-manager/common.nix
          ./home-manager/darwin.nix
        ];

        extraSpecialArgs = {
          inherit inputs;
          local = {
            user = "sawada";
          };
        };
      };
      workbench = home-manager.lib.homeManagerConfiguration rec {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;

        modules = [
          ./home-manager/common.nix
          ./home-manager/linux-common.nix
          ./home-manager/linux-nongui.nix
        ];

        extraSpecialArgs = {
          inherit inputs;
          local = {
            user = "ubuntu";
          };
        };
      };
    };
  };
}
