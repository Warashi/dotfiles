{
  inputs,
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
      source = inputs.skk-jisyo-L + "/SKK-JISYO.L";
      target = ".config/skk/SKK-JISYO.L";
    };
    wikidict = {
      source = inputs.skk-jisyo-jawiki + "/SKK-JISYO.jawiki";
      target = ".config/skk/SKK-JISYO.jawiki";
    };
    bat-catppuccin-latte = {
      source = inputs.bat-catppuccin-latte + /Catppuccin-latte.tmTheme;
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
