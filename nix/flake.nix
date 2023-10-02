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
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    skk-jisyo-L = {
      url = "github:skk-dev/dict";
      flake = false;
    };
    skk-jisyo-jawiki = {
      url = "github:tokuhirom/jawiki-kana-kanji-dict";
      flake = false;
    };
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-zsh-fsh = {
      url = "github:catppuccin/zsh-fsh";
      flake = false;
    };
    catppuccin-rofi = {
      url = "github:catppuccin/rofi";
      flake = false;
    };
    catppuccin-polybar = {
      url = "github:catppuccin/polybar";
      flake = false;
    };
    catppuccin-dunst = {
      url = "github:catppuccin/dunst";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    xremap-flake,
    ...
  }: rec {
    flakeInputs = inputs;

    nixos = {
      modules = [
        ./nixos/config.nix
      ];
    };
    darwin = {
      modules = [
        ./nix-darwin/host.nix
        ./nix-darwin/config.nix
      ];
      specialArgs = {inherit self;};
    };
    homeManagerBase = {
      modules = [
        ./home-manager/common.nix
      ];
    };
    homeManagerDarwin =
      homeManagerBase
      // {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules =
          homeManagerBase.modules
          ++ [
            ./home-manager/darwin.nix
          ];
      };
    homeManagerLinuxBase =
      homeManagerBase
      // {
        modules =
          homeManagerBase.modules
          ++ [
            ./home-manager/linux-common.nix
          ];
      };
    homeManagerLinuxNonGUI =
      homeManagerLinuxBase
      // {
        modules =
          homeManagerLinuxBase.modules
          ++ [
            ./home-manager/linux-nongui.nix
          ];
      };
    homeManagerLinuxGUI =
      homeManagerLinuxBase
      // {
        modules =
          homeManagerLinuxBase.modules
          ++ [
            xremap-flake.homeManagerModules.default
            ./home-manager/linux-gui.nix
          ];
      };

    nixosConfigurations = {
      parallels = nixpkgs.lib.nixosSystem (nixos
        // {
          system = "aarch64-linux";
          modules =
            nixos.modules
            ++ [
              ./nixos/hosts/parallels/config.nix
            ];
        });
    };

    darwinConfigurations = {
      warashi = nix-darwin.lib.darwinSystem darwin;
    };

    homeConfigurations = {
      parallels = home-manager.lib.homeManagerConfiguration (homeManagerLinuxGUI
        // {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          extraSpecialArgs = {
            inherit inputs;
            local = {
              user = "warashi";
            };
          };
        });

      warashi = home-manager.lib.homeManagerConfiguration (homeManagerDarwin
        // {
          extraSpecialArgs = {
            inherit inputs;
            local = {
              user = "sawada";
            };
          };
        });

      workbench = home-manager.lib.homeManagerConfiguration (homeManagerLinuxNonGUI
        // {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;

          extraSpecialArgs = {
            inherit inputs;
            local = {
              user = "ubuntu";
            };
          };
        });
    };
  };
}
