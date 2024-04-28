{
  inputs,
  home,
  pkgs,
  ...
}: {
  home.file = {
    rgfind = {
      target = ".local/bin/rgfind";
      source = ./files/rgfind;
      executable = true;
    };
    emacs-early-init-el = {
      target = ".emacs.d/early-init.el";
      source = ./emacs/early-init.el;
    };
    emacs-ddskk-init-el = {
      target = ".emacs.d/ddskk/init.el";
      source = ./emacs/ddskk/init.el;
    };
  };
  xdg = {
    enable = true;
    configFile = {
      catppuccin-bat = {
        source = inputs.catppuccin-bat + /themes;
        target = "bat/themes";
        recursive = true;
      };
      catppuccin-zsh-fast-syntax-highligiting = {
        source = inputs.catppuccin-zsh-fsh + /themes;
        target = "fsh";
        recursive = true;
      };
      catppuccin-glamour-latte = {
        source = pkgs.fetchurl {
          url = "https://github.com/catppuccin/glamour/releases/download/v1.0.0/latte.json";
          sha256 = "sha256-V0LsRStF1vL+Tz8G6VaKiwiY/ZIsSkMc+f1WJAITYXU=";
        };
        target = "glamour/catppuccin-latte.json";
      };
      catppuccin-glamour-frappe = {
        source = pkgs.fetchurl {
          url = "https://github.com/catppuccin/glamour/releases/download/v1.0.0/frappe.json";
          sha256 = "sha256-YOatgYCJKuesVERHZVmF1xtzuLjyxCYstoWYqATq+NU=";
        };
        target = "glamour/catppuccin-frappe.json";
      };
    };
  };
}
