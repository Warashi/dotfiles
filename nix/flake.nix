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

    twist = {
      url = "github:emacs-twist/twist.nix";
    };
    org-babel = {
      url = "github:emacs-twist/org-babel";
    };

    melpa = {
      url = "github:melpa/melpa";
      flake = false;
    };
    gnu-elpa = {
      url = "git+https://git.savannah.gnu.org/git/emacs/elpa.git?ref=main";
      flake = false;
    };
    nongnu = {
      url = "git+https://git.savannah.gnu.org/git/emacs/nongnu.git?ref=main";
      flake = false;
    };
    epkgs = {
      url = "github:emacsmirror/epkgs";
      flake = false;
    };
    emacs = {
      url = "github:emacs-mirror/emacs";
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
    inherit (configurations) devShells apps packages;

    flakeInputs = inputs;

    nixosConfigurations = {
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
    };

    configurations = flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.twist.overlays.default
            inputs.org-babel.overlays.default
          ];
        };

        inherit (pkgs) lib;

        emacs-config = pkgs.emacsTwist {
          emacsPackage = pkgs.emacs;

          nativeCompileAheadDefault = true;
          registries = import ./emacs/registries.nix inputs;
          lockDir = ./emacs/lock;
          exportManifest = true;

          initFiles = [
            (pkgs.tangleOrgBabelFile "init.el" ./emacs/emacs-config.org {})
            (let
              libExt = pkgs.stdenv.hostPlatform.extensions.sharedLibrary;
              grammarToAttrSet = drv: {
                name = "lib${lib.strings.removeSuffix "-grammar" (lib.strings.getName drv)}${libExt}";
                path = "${drv}/parser";
              };
              with-grammars = fn:
                pkgs.linkFarm "emacs-treesit-grammars"
                (map grammarToAttrSet (fn pkgs.tree-sitter.builtGrammars));
              with-all-grammars = with-grammars builtins.attrValues;
            in
              pkgs.writeText "init-treesit.el" ''
                (add-to-list 'treesit-extra-load-path "${with-all-grammars}/")
              '')
          ];

          inputOverrides = with (pkgs.emacsPackages); {
            vterm = _: _: {
              src = vterm + "/share/emacs/site-lisp/elpa/vterm-${vterm.version}";
            };
          };
        };
      in rec {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.coreutils
            ];
          };
        };

        packages = flake-utils.lib.flattenTree {
          inherit emacs-config;
        };

        apps = emacs-config.makeApps {
          lockDirName = "emacs/lock";
        };

        homeModules = {
          twist = {
            imports = [
              inputs.twist.homeModules.emacs-twist
              (import ./emacs/home-module.nix emacs-config)
            ];
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
        };

        nixosNonGUI = modules: {
          inherit system;
          modules =
            [
              ./nixos/common/config.nix
            ]
            ++ modules;
        };
        darwin = modules: {
          modules =
            [
              ./nix-darwin/config.nix
              (_: {nixpkgs.hostPlatform = system;})
            ]
            ++ modules;
          specialArgs = {inherit self;};
        };
        homeManagerBase = {
          modules,
          user,
        }: {
          inherit pkgs;
          modules =
            [
              ./home-manager/common/default.nix
              homeModules.twist
            ]
            ++ modules;
          extraSpecialArgs = {
            inherit inputs;
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
