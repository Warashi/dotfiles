{
  description = "Home Manager configuration of sawada";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
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
    fcitx5-hazkey = {
      url = "github:Warashi/nix-fcitx5-hazkey";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    hyprsome = {
      url = "github:sopa0/hyprsome";
    };
    catppuccin.url = "github:catppuccin/nix";
    flatpaks.url = "github:GermanBread/declarative-flatpak/dev"; # Please DO NOT override the "nixpkgs" input!
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
    emacs-src = {
      url = "github:emacs-mirror/emacs";
      flake = false;
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    emacs-copilot = {
      url = "github:copilot-emacs/copilot.el";
      flake = false;
    };
    emacs-term-title = {
      url = "github:CyberShadow/term-title";
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

  outputs =
    inputs@{
      self,
      flake-utils,
      nixpkgs,
      nix-darwin,
      home-manager,
      xremap-flake,
      flatpaks,
      ...
    }:
    rec {
      flakeInputs = inputs;

      nixosConfigurations = {
        orbstack = nixpkgs.lib.nixosSystem (
          configurations.nixosNonGUI.aarch64-linux [
            ./nixos/hosts/orbstack/config.nix
            ./nixos/optional/docker.nix
            {
              home-manager = {
                inherit (homeConfigurations.orbstack) extraSpecialArgs;
                users.warashi = {
                  imports = homeConfigurations.orbstack.modules;
                };
              };
            }
          ]
        );

        duna = nixpkgs.lib.nixosSystem (
          configurations.nixosGUI.x86_64-linux [
            ./nixos/hosts/duna/default.nix
            ./nixos/optional/docker.nix
            {
              home-manager = {
                backupFileExtension = "backup";
                inherit (homeConfigurations.duna) extraSpecialArgs;
                users.warashi = {
                  imports = homeConfigurations.duna.modules;
                };
              };
            }
          ]
        );
      };

      darwinConfigurations = {
        warashi = nix-darwin.lib.darwinSystem (configurations.darwin.aarch64-darwin [ ]);
        tisza = nix-darwin.lib.darwinSystem (configurations.darwin.x86_64-darwin [ ]);
      };

      homeConfigurations = {
        warashi = home-manager.lib.homeManagerConfiguration (
          configurations.homeManagerDarwin.aarch64-darwin {
            modules = [ ];
            user = "sawada";
          }
        );

        tisza = home-manager.lib.homeManagerConfiguration (
          configurations.homeManagerDarwin.x86_64-darwin {
            modules = [ ];
            user = "warashi";
          }
        );

        duna = (
          configurations.homeManagerLinuxGUI.x86_64-linux {
            modules = [
              ./home-manager/linux-gui/desktop/hidpi.nix
            ];
            user = "warashi";
          }
        );

        workbench = home-manager.lib.homeManagerConfiguration (
          configurations.homeManagerLinuxNonGUI.aarch64-linux {
            modules = [ ];
            user = "opc";
          }
        );

        orbstack = (
          configurations.homeManagerLinuxNonGUI.aarch64-linux {
            modules = [
              {
                programs.bash.bashrcExtra = ''
                  if [[ -S /opt/orbstack-guest/run/host-ssh-agent.sock ]]; then
                     export SSH_AUTH_SOCK=/opt/orbstack-guest/run/host-ssh-agent.sock
                  fi
                '';
                programs.zsh.initExtra = ''
                  if [[ -S /opt/orbstack-guest/run/host-ssh-agent.sock ]]; then
                     export SSH_AUTH_SOCK=/opt/orbstack-guest/run/host-ssh-agent.sock
                  fi
                '';
              }
            ];
            user = "warashi";
          }
        );
      };

      configurations = flake-utils.lib.eachDefaultSystem (system: rec {
        pkgs = nixpkgs.legacyPackages.${system};

        emacs =
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [
                inputs.emacs-overlay.overlays.default
              ];
            };
          in
          {
            package = pkgs.callPackage ./emacs/default.nix {
              inherit inputs;
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
          modules = [
            ./nixos/common/config.nix
            ./nixos/gui/config.nix
            inputs.nixos-facter-modules.nixosModules.facter
            inputs.home-manager.nixosModules.home-manager
            inputs.catppuccin.nixosModules.catppuccin
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
            }
          ] ++ modules;
          specialArgs = {
            inherit emacs inputs;
          };
        };
        nixosNonGUI = modules: {
          inherit system;
          modules = [
            ./nixos/common/config.nix
            inputs.nixos-facter-modules.nixosModules.facter
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
            }
          ] ++ modules;
          specialArgs = {
            inherit emacs inputs;
          };
        };
        darwin = modules: {
          modules = [
            ./nix-darwin/config.nix
            (_: { nixpkgs.hostPlatform = system; })

            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
            }
          ] ++ modules;
          specialArgs = {
            inherit self emacs;
          };
        };
        homeManagerBase =
          {
            modules,
            user,
          }:
          {
            inherit pkgs;
            modules = [
              ./home-manager/common/default.nix
              inputs.catppuccin.homeManagerModules.catppuccin
            ] ++ modules;
            extraSpecialArgs = {
              inherit inputs emacs;
              local = {
                inherit user;
              };
            };
          };
        homeManagerDarwin =
          {
            modules,
            user,
          }:
          homeManagerBase {
            inherit user;
            modules = modules ++ [
              ./home-manager/darwin/default.nix
            ];
          };
        homeManagerLinuxBase =
          {
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
        homeManagerLinuxNonGUI =
          {
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
        homeManagerLinuxGUI =
          {
            modules,
            user,
          }:
          homeManagerLinuxBase {
            inherit user;
            modules = (
              modules
              ++ [
                flatpaks.homeManagerModules.declarative-flatpak
                xremap-flake.homeManagerModules.default
                ./home-manager/linux-gui/default.nix
              ]
            );
          };
      });
    };
}
