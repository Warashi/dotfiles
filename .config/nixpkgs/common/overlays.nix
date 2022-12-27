{pkgs}: let
  locale =
    if pkgs.stdenv.isDarwin
    then pkgs.darwin.locale
    else pkgs.glibcLocales;
in [
  # (import (builtins.fetchTarball {
  #   url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
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
]
