{
  inputs,
  emacs,
  pkgs,
  ...
}:
{
  home.file = emacs.files // {
    rgfind = {
      target = ".local/bin/rgfind";
      source = ./files/rgfind;
      executable = true;
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
        source = inputs.catppuccin-glamour + /themes;
        target = "glamour";
        recursive = true;
      };
    };
  };
}
