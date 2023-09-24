{
  inputs,
  programs,
  ...
}: {
  home.file.catppuccin-rio = {
    source = inputs.catppuccin-rio;
    target = ".config/rio/themes";
    recursive = true;
  };
  programs.rio = {
    enable = true;
    settings = {
      theme = "catppuccin-latte";
      fonts = {
        size = 24;
        regular = {
          family = "PlemolJP Console NF";
          style = "Regular";
          weight = 100;
        };
        bold = {
          family = "PlemolJP Console NF";
          style = "Regular";
          weight = 100;
        };
        italic = {
          family = "PlemolJP Console NF";
          style = "Regular";
          weight = 100;
        };
        bold-italic = {
          family = "PlemolJP Console NF";
          style = "Regular";
          weight = 100;
        };
      };
    };
  };
}
