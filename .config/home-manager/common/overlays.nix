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
    mosh =
      prev.mosh.overrideAttrs
      (_: {
        patches =
          prev.mosh.patches
          ++ [
            (prev.fetchpatch {
              name = "improve_cursor_style_handling_pr-1167.patch";
              url = "https://patch-diff.githubusercontent.com/raw/mobile-shell/mosh/pull/1167.patch";
              sha256 = "ratfcw8gvvwhTpjCSdHPznEDp/jpBtx0Xavbx03pTDg=";
            })
          ];
        postInstall =
          prev.mosh.postInstall
          + ''
            wrapProgram $out/bin/mosh-server --set LOCALE_ARCHIVE ${locale}/lib/locale/locale-archive;
          '';
      });
  })
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
    vivid =
      prev.vivid.overrideAttrs
      (old: rec {
        inherit (old) pname;
        version = "0.9.0-pre";

        src = prev.fetchFromGitHub {
          owner = "sharkdp";
          repo = pname;
          rev = "4d7fb24d5481cb104292b97a993fc4448d854bc1";
          sha256 = "sha256-rfEkeNrC5LHmUnTGv3tpIzpF+aSDCNmsnNsBQ/GC3Q4=";
        };

        cargoDeps = old.cargoDeps.overrideAttrs (prev.lib.const {
          inherit src;
          name = "${old.pname}-${version}-vendor.tar.gz";
          outputHash = "sha256-DvUX7Eox6W8n9aHZNWMl3DTqHw6xcvyqH78QExCKM3Y=";
        });

        # doCheck = false;

        # meta.platforms = prev.lib.platforms.unix;
      });
  })
]
