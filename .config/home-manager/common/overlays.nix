{pkgs}: let
  locale =
    if pkgs.stdenv.isDarwin
    then pkgs.darwin.locale
    else pkgs.glibcLocales;
in [
  # neovim nightly を使うときはここを適切に変更する
  # (import (builtins.fetchTarball {
  #   url = "https://github.com/nix-community/neovim-nightly-overlay/archive/b7ae7ef7cc841eebb365840a90341a5555ed93f5.tar.gz";
  # }))
  (_: prev: {
    sheldon =
      prev.sheldon.overrideAttrs
      (old: rec {
        inherit (old) pname;
        version = "0.7.3";

        src = prev.fetchCrate {
          inherit pname version;
          sha256 = "sha256-uis3a16bGfycGzjmG6RjSCCgc1x+0LGuKKXX4Cs+NGc=";
        };

        cargoDeps = old.cargoDeps.overrideAttrs (prev.lib.const {
          inherit src;
          name = "${old.pname}-${version}-vendor.tar.gz";
          outputHash = "sha256-wVB+yL+h90f7NnASDaX5gxT5z45M8I1rxIJwY8uyB4k=";
        });

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
    mocword-data = prev.stdenv.mkDerivation rec {
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

      meta = with prev.lib; {
        homepage = "https://github.com/high-moctane/mocword-data";
      };
    };
  })
  (_: prev: {
    muscat = prev.buildGo121Module rec {
      pname = "muscat";
      version = "2.1.0";
      vendorSha256 = "sha256-F6VLn0t//8qvhG+KHBmnUywHIy67rSm07ncVH5HD4/4=";

      src = prev.fetchFromGitHub {
        owner = "Warashi";
        repo = pname;
        rev = "v${version}";
        sha256 = "sha256-hTrzJH1DzNDgnR+ztBfCAtHNpYWFVYv32XjO0NSGURg=";
      };

      postInstall = ''
        cd $out/bin
        for link in lemonade pbcopy pbpaste xdg-open; do
          ln -s muscat $link
        done
      '';

      meta = with prev.lib; {
        description = "remote code development utils";
        homepage = "https://github.com/Warashi/muscat";
        license = licenses.mit;
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
]
