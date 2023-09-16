{
  home,
  pkgs,
  ...
}: {
  home.file = {
    cspel = {
      target = ".config/cspell/cspell.json";
      source = ./. + "/files/cspell.json";
    };
    nvredit = {
      target = ".local/bin/nvredit";
      source = ./. + "/files/nvredit";
      executable = true;
    };
    rgfind = {
      target = ".local/bin/rgfind";
      source = ./. + "/files/rgfind";
      executable = true;
    };
    oj-template = {
      target = ".config/online-judge-tools/template/main.go";
      text = ''
        package main

        import "github.com/Warashi/go-atcoder/lib/myio"

        func main() {
        	defer myio.Flush()

        }
      '';
    };
    largedict = {
      source =
        pkgs.fetchFromGitHub {
          owner = "skk-dev";
          repo = "dict";
          rev = "1909dda026e6038975359a5eaeafcf50c9ce7fa3";
          sha256 = "sha256-e7B1+ji/8ssM92RSTmlu8c7V5kbk93CxtUDzs26gE8s=";
        }
        + "/SKK-JISYO.L";
      target = ".config/skk/SKK-JISYO.L";
    };
    wikidict = {
      source =
        pkgs.fetchFromGitHub {
          owner = "tokuhirom";
          repo = "jawiki-kana-kanji-dict";
          rev = "43af3f7cc2dc1ad7bac58dcf44dd4ab22436135b";
          sha256 = "sha256-H+cEDsWjvbS9QaWSfhSbdZQx6yIv7HMRIgLZ/0qCdME=";
        }
        + "/SKK-JISYO.jawiki";
      target = ".config/skk/SKK-JISYO.jawiki";
    };
    bat-catppuccin-latte = {
      source =
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        }
        + /Catppuccin-latte.tmTheme;
      target = ".config/bat/themes/Catppuccin-latte.tmTheme";
    };
    glamour-catppuccin-latte = {
      source = pkgs.fetchurl {
        url = "https://github.com/catppuccin/glamour/releases/download/v1.0.0/latte.json";
        sha256 = "sha256-V0LsRStF1vL+Tz8G6VaKiwiY/ZIsSkMc+f1WJAITYXU=";
      };
      target = ".config/glamour/catppuccin-latte.json";
    };
    catppuccin-zsh-fast-syntax-highligiting = {
      source =
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-fsh";
          rev = "7cdab58bddafe0565f84f6eaf2d7dd109bd6fc18";
          sha256 = "sha256-31lh+LpXGe7BMZBhRWvvbOTkwjOM77FPNaGy6d26hIA=";
        }
        + /themes;
      target = ".config/fsh";
      recursive = true;
    };
  };
}
