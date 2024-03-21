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
    denops-vim = {
      url = "github:vim-denops/denops.vim";
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
    fennel-language-server = {
      url = "github:rydesun/fennel-language-server";
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
    my-emacs = {
      url = "./emacs";
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

    nixosGUI = {
      modules = [
        ./nixos/common/config.nix
        ./nixos/gui/config.nix
      ];
    };
    nixosNonGUI = {
      modules = [
        ./nixos/common/config.nix
      ];
    };
    darwin = {
      modules = [
        ./nix-darwin/config.nix
      ];
      specialArgs = {inherit self;};
    };
    homeManagerBase = {
      modules = [
        ./home-manager/common/default.nix
      ];
    };
    homeManagerDarwin =
      homeManagerBase
      // {
        modules =
          homeManagerBase.modules
          ++ [
            ./home-manager/darwin/default.nix
            inputs.my-emacs.homeModules.aarch64-darwin.twist
          ];
      };
    homeManagerLinuxBase =
      homeManagerBase
      // {
        modules =
          homeManagerBase.modules
          ++ [
            ./home-manager/linux/default.nix
          ];
      };
    homeManagerLinuxNonGUI =
      homeManagerLinuxBase
      // {
        modules =
          homeManagerLinuxBase.modules
          ++ [
            ./home-manager/linux-nongui/default.nix
          ];
      };
    homeManagerLinuxGUI =
      homeManagerLinuxBase
      // {
        modules =
          homeManagerLinuxBase.modules
          ++ [
            xremap-flake.homeManagerModules.default
            ./home-manager/linux-gui/default.nix
          ];
      };

    nixosConfigurations = {
      orbstack = nixpkgs.lib.nixosSystem (nixosNonGUI
        // {
          system = "aarch64-linux";
          modules =
            nixosNonGUI.modules
            ++ [
              ./nixos/hosts/orbstack/config.nix
            ];
        });

      parallels = nixpkgs.lib.nixosSystem (nixosGUI
        // {
          system = "aarch64-linux";
          modules =
            nixosGUI.modules
            ++ [
              ./nixos/hosts/parallels/config.nix
            ];
        });
    };

    darwinConfigurations = {
      warashi = nix-darwin.lib.darwinSystem (darwin
        // {
          modules =
            darwin.modules
            ++ [
              (_: {nixpkgs.hostPlatform = "aarch64-darwin";})
            ];
        });

      tisza = nix-darwin.lib.darwinSystem (darwin
        // {
          modules =
            darwin.modules
            ++ [
              (_: {nixpkgs.hostPlatform = "x86_64-darwin";})
            ];
        });
    };

    homeConfigurations = {
      orbstack = home-manager.lib.homeManagerConfiguration (homeManagerLinuxNonGUI
        // {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;

          extraSpecialArgs = {
            inherit inputs;
            local = {
              user = "sawada";
            };
          };
        });

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
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = {
            inherit inputs;
            local = {
              user = "sawada";
            };
          };
        });

      tisza = home-manager.lib.homeManagerConfiguration (homeManagerDarwin
        // {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          extraSpecialArgs = {
            inherit inputs;
            local = {
              user = "warashi";
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
