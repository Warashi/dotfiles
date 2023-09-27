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
    catppuccin-bat = {
      source = inputs.catppuccin-bat;
      target = ".config/bat/themes";
      recursive = true;
    };
    catppuccin-zsh-fast-syntax-highligiting = {
      source = inputs.catppuccin-zsh-fsh + /themes;
      target = ".config/fsh";
      recursive = true;
    };
    catppuccin-glamour-latte = {
      source = pkgs.fetchurl {
        url = "https://github.com/catppuccin/glamour/releases/download/v1.0.0/latte.json";
        sha256 = "sha256-V0LsRStF1vL+Tz8G6VaKiwiY/ZIsSkMc+f1WJAITYXU=";
      };
      target = ".config/glamour/catppuccin-latte.json";
    };
    catppuccin-glamour-frappe = {
      source = pkgs.fetchurl {
        url = "https://github.com/catppuccin/glamour/releases/download/v1.0.0/frappe.json";
        sha256 = "sha256-YOatgYCJKuesVERHZVmF1xtzuLjyxCYstoWYqATq+NU=";
      };
      target = ".config/glamour/catppuccin-frappe.json";
    };
  };
}
