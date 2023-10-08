{ inputs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${inputs.catppuccin-alacritty + "/catppuccin-frappe.yml"}"
      ];
      env = {
        TERM = "xterm-256color";
      };
      window = {
        opacity = 1.0;
        options_as_alt = "Both";
        padding = {
          x = 10;
          y = 10;
        };
      };
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
