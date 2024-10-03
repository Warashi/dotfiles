{
  pkgs,
  lib,
  ...
}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      window =
        {
          opacity = 1.0;
          padding = {
            x = 0;
            y = 0;
          };
        }
        // (lib.optionalAttrs pkgs.stdenv.isDarwin {
          option_as_alt = "Both";
        });
      scrolling = {
        history = 0;
      };
      font = {
        size = 13.0;
        normal = {
          family = "PlemolJP Console NF";
          style = "Regular";
        };
        bold = {
          family = "PlemolJP Console NF";
          style = "Bold";
        };
        italic = {
          family = "PlemolJP Console NF";
          style = "Regular Italic";
        };
        bold_italic = {
          family = "PlemolJP Console NF";
          style = "Bold Italic";
        };
      };
    };
  };
}
