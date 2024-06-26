{inputs, pkgs, ...}: {
  nixpkgs.overlays = [
    # neovim nightly を使うときはここからneovim-unwrappedのoverlayまでを適切に変更する
    # inputs.neovim-nightly-overlay.overlays.default
    # (_: prev: {
    #   neovim-unwrapped = prev.neovim-unwrapped.override {
    #     inherit (prev.llvmPackages_latest) stdenv;
    #   };
    # })
    (_: _: {
      muscat = inputs.muscat.packages.${pkgs.hostPlatform.system}.default;
    })
    (_: _: {
      fcitx5-hazkey = (pkgs.qt6Packages.callPackage ./packages/fcitx5-hazkey.nix {
        inherit (inputs) hazkey-src;
        inherit (pkgs) fcitx5 swift vulkan-headers vulkan-loader vulkan-tools;
        inherit (pkgs.swiftPackages) swiftpm;
      });
    })
    (_: prev: {
      sheldon =
        prev.sheldon.overrideAttrs
        (_: {
          doCheck = false;
          meta.platforms = prev.lib.platforms.unix;
        });
    })
    (_: prev: {
      mocword = prev.rustPlatform.buildRustPackage rec {
        pname = "mocword";
        version = "0.2.0";

        src = prev.fetchCrate {
          inherit pname version;
          sha256 = "sha256-DGQebd+doauYnrKrx0ejkwD8Cgcd6zsPad3mbSa0zXo=";
        };

        cargoHash = "sha256-BJJDjwasGBbFfQWfZC6msEVOewD0iNyZeF5MpXBN8iM=";

        meta = with prev.lib; {
          description = "Predict next words (｀･ω･´)";
          homepage = "https://crates.io/crates/mocword";
          license = licenses.mit;
        };
      };
    })
    (_: prev: {
      mocword-data = prev.stdenv.mkDerivation {
        pname = "mocword-data";
        version = "0.0.1";

        outputs = ["out"];

        src = prev.fetchurl {
          url = "https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz";
          sha256 = "sha256-5tyCED6A7ujn96D+D7Yc7vKKG5ZpF798P7tCk3wqEEA=";
        };

        nativeBuildInputs = [prev.gzip];
        buildInputs = [];

        unpackPhase = ''
          cp $src mocword.sqlite.gz
          gzip -d mocword.sqlite.gz
        '';

        installPhase = ''
          mkdir -p $out
          cp mocword.sqlite $out/
        '';

        meta = {
          homepage = "https://github.com/high-moctane/mocword-data";
        };
      };
    })
    (_: prev: {
      tmux-mvr = prev.rustPlatform.buildRustPackage rec {
        pname = "tmux-mvr";
        version = "0.0.3";

        src = prev.fetchFromGitHub {
          owner = "Warashi";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-3y12Obb/hBF74KbipclpX3EKCIrVvWKqy7fxJE4VGzc=";
        };

        cargoHash = "sha256-xqk4YC6mcDef1Z7Xt9U62B/FprxBRN+WXF1zhICquxo=";
        doCheck = false;

        meta = with prev.lib; {
          description = "tmux main-vertical with right side main pane";
          homepage = "https://github.com/Warashi/tmux-mvr";
          license = licenses.mit;
        };
      };
    })
    (_: prev: {
      tmuxPlugins =
        prev.tmuxPlugins
        // {
          tmux-1password = prev.tmuxPlugins.mkTmuxPlugin {
            pluginName = "1password";
            rtpFilePath = "plugin.tmux";
            version = "0.0.1";
            src = prev.fetchFromGitHub {
              owner = "Warashi";
              repo = "tmux-1password";
              rev = "1bd0276a4325750795ec373ef6c5bad5e29bcb64";
              hash = "sha256-cTlYgAGXWzePX3muDSwBfuCtLsJ+YsvHiIGrmczAYvo=";
            };
            meta = with prev.lib; {
              description = "1password integration for tmux";
              homepage = "https://github.com/Warashi/tmux-1password";
              license = licenses.mit;
            };
          };
        };
    })
    (_: prev: {
      yaskkserv2 = prev.rustPlatform.buildRustPackage rec {
        pname = "yaskkserv2";
        version = "0.1.7";
        buildInputs =
          [
            prev.openssl
          ]
          ++ (
            if prev.stdenv.isDarwin
            then [
              prev.darwin.apple_sdk.frameworks.Security
            ]
            else []
          );
        nativeBuildInputs = [
          prev.pkg-config
        ];

        src = prev.fetchFromGitHub {
          owner = "wachikun";
          repo = pname;
          rev = "${version}";
          sha256 = "sha256-bF8OHP6nvGhxXNvvnVCuOVFarK/n7WhGRktRN4X5ZjE=";
        };

        cargoLock = {
          lockFile = src + "/Cargo.lock";
        };
        doCheck = false;

        meta = with prev.lib; {
          description = "Yet Another SKK server";
          homepage = "https://github.com/wachikun/yaskkserv2";
          license = licenses.mit;
        };
      };
    })
    (_: prev: {
      plemoljp = prev.stdenvNoCC.mkDerivation rec {
        pname = "plemoljp-console-nf";
        version = "1.6.0";

        src = prev.fetchzip {
          url = "https://github.com/yuru7/PlemolJP/releases/download/v${version}/PlemolJP_NF_v${version}.zip";
          hash = "sha256-AYf/ymueqVR45mERfhNWRAA+3o1wTzIu0l+h0SsE/Hw=";
        };

        installPhase = ''
          runHook preInstall

          install -Dm644 PlemolJPConsole_NF/*.ttf -t $out/share/fonts/truetype

          runHook postInstall
        '';
      };
    })
    (_: prev: {
      fennel-language-server = prev.rustPlatform.buildRustPackage rec {
        pname = "fennel-language-server";
        version = "dev-" + inputs.fennel-language-server.lastModifiedDate;

        src = inputs.fennel-language-server;

        cargoLock = {
          lockFile = src + "/Cargo.lock";
        };
        doCheck = false;

        meta = with prev.lib; {
          description = "Fennel language server protocol (LSP) support.";
          homepage = "https://github.com/rydesun/fennel-language-server";
          license = licenses.mit;
        };
      };
    })
  ];
}
