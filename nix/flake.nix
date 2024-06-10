{
  description = "Home Manager configuration of sawada";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    muscat = {
      url = "github:Warashi/muscat";
    };
    neovim-src = {
      url = "github:neovim/neovim";
      flake = false;
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        neovim-src.follows = "neovim-src";
      };
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    emacs-copilot = {
      url = "github:copilot-emacs/copilot.el";
      flake = false;
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
    catppuccin-glamour = {
      url = "github:catppuccin/glamour";
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
    flake-utils,
    nixpkgs,
    nix-darwin,
    home-manager,
    xremap-flake,
    ...
  }: rec {
    flakeInputs = inputs;

    nixosConfigurations = {
      orbstack = nixpkgs.lib.nixosSystem (configurations.nixosNonGUI.aarch64-linux [
        ./nixos/hosts/orbstack/config.nix
        ./nixos/optional/docker.nix
      ]);
    };

    darwinConfigurations = {
      warashi = nix-darwin.lib.darwinSystem (configurations.darwin.aarch64-darwin []);
      tisza = nix-darwin.lib.darwinSystem (configurations.darwin.x86_64-darwin []);
    };

    homeConfigurations = {
      warashi = home-manager.lib.homeManagerConfiguration (
        configurations.homeManagerDarwin.aarch64-darwin {
          modules = [];
          user = "sawada";
        }
      );

      tisza = home-manager.lib.homeManagerConfiguration (
        configurations.homeManagerDarwin.x86_64-darwin {
          modules = [];
          user = "warashi";
        }
      );
      
      orbstack = home-manager.lib.homeManagerConfiguration (
        configurations.homeManagerLinuxNonGUI.aarch64-linux {
          modules = [
            inputs.vscode-server.homeModules.default
            (_:{
              services.vscode-server.enable = true;
            })
          ];
          user = "warashi";
        }
      );
    };

    configurations = flake-utils.lib.eachDefaultSystem (
      system: rec {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.emacs-overlay.overlays.default
          ];
        };

        emacs = {
          package = import ./emacs/default.nix {
            inherit inputs pkgs;
          };
          files = {
            emacs-early-init-el = {
              target = ".emacs.d/early-init.el";
              source = ./emacs/early-init.el;
            };
            emacs-ddskk-init-el = {
              target = ".emacs.d/ddskk/init.el";
              source = ./emacs/ddskk/init.el;
            };
          };
        };

        nixosGUI = modules: {
          inherit system;
          modules =
            [
              ./nixos/common/config.nix
              ./nixos/gui/config.nix
            ]
            ++ modules;
          specialArgs = {inherit emacs;};
        };
        nixosNonGUI = modules: {
          inherit system;
          modules =
            [
              ./nixos/common/config.nix
            ]
            ++ modules;
          specialArgs = {inherit emacs;};
        };
        darwin = modules: {
          modules =
            [
              ./nix-darwin/config.nix
              (_: {nixpkgs.hostPlatform = system;})
            ]
            ++ modules;
          specialArgs = {inherit self emacs;};
        };
        homeManagerBase = {
          modules,
          user,
        }: {
          inherit pkgs;
          modules =
            [
              ./home-manager/common/default.nix
            ]
            ++ modules;
          extraSpecialArgs = {
            inherit inputs emacs;
            local = {
              inherit user;
            };
          };
        };
        homeManagerDarwin = {
          modules,
          user,
        }:
          homeManagerBase {
            inherit user;
            modules =
              modules
              ++ [
                ./home-manager/darwin/default.nix
              ];
          };
        homeManagerLinuxBase = {
          modules,
          user,
        }:
          homeManagerBase {
            inherit user;
            modules = (
              modules
              ++ [
                ./home-manager/linux/default.nix
              ]
            );
          };
        homeManagerLinuxNonGUI = {
          modules,
          user,
        }:
          homeManagerLinuxBase {
            inherit user;
            modules = (
              modules
              ++ [
                ./home-manager/linux-nongui/default.nix
              ]
            );
          };
        homeManagerLinuxGUI = {
          modules,
          user,
        }:
          homeManagerLinuxBase {
            inherit user;
            pmodules = (
              modules
              ++ [
                xremap-flake.homeManagerModules.default
                ./home-manager/linux-gui/default.nix
              ]
            );
          };
      }
    );
  };
}
