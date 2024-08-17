{
  inputs,
  pkgs,
  ...
}: {
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
    (_: prev: {
      sheldon =
        if prev.stdenv.isDarwin
        then
          prev.sheldon.overrideAttrs (_: {
            doCheck = false;
            meta.platforms = prev.lib.platforms.unix;
          })
        else prev.sheldon;
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
  ];
}
