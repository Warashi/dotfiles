{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
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

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.twist.overlays.default
            inputs.org-babel.overlays.default
          ];
        };

        emacs-config = pkgs.emacsTwist {
          emacsPackage = pkgs.emacs;

          registries = import ./registries.nix inputs;
          lockDir = ./lock;
          exportManifest = true;

          initFiles = [
            (pkgs.tangleOrgBabelFile "init.el" ./emacs-config.org {})
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
          lockDirName = "lock";
        };

        homeModules = {
          twist = {
            imports = [
              inputs.twist.homeModules.emacs-twist
              (import ./home-module.nix self.packages.${system})
            ];
          };
        };

        defaultPackage = packages.emacs-config;
      }
    );
}
