{
  inputs,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${inputs.catppuccin-alacritty + "/catppuccin-frappe.toml"}"
      ];
      env = {
        TERM = "xterm-256color";
      };
      window =
        {
          opacity = 1.0;
          padding = {
            x = 10;
            y = 10;
          };
        }
        // (
          if pkgs.stdenv.isDarwin
          then {
            option_as_alt = "Both";
          }
          else {}
        );
      scrolling = {
        history = 0;
      };
      font = {
        size = 18.0;
        offset = {
          x = 2;
          y = 4;
        };
        glyph_offset = {
          x = 1;
          y = 2;
        };
        normal = {
          family = "PlemolJP Console NF";
          style = "ExtraLight";
        };
        bold = {
          family = "PlemolJP Console NF";
          style = "Regular";
        };
        italic = {
          family = "PlemolJP Console NF";
          style = "ExtraLight Italic";
        };
        bold_italic = {
          family = "PlemolJP Console NF";
          style = "Regular Italic";
        };
      };
    };
  };
}
