{ programs, pkgs, ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      default_mode = "locked";
      copy_command = "muscat copy";
      theme = "nord";
      themes.nord = {
        fg = [ 216 222 233 ]; #D8DEE9
        bg = [ 46 52 64 ]; #2E3440
        black = [ 59 66 82 ]; #3B4252
        red = [ 191 97 106 ]; #BF616A
        green = [ 163 190 140 ]; #A3BE8C
        yellow = [ 235 203 139 ]; #EBCB8B
        blue = [ 129 161 193 ]; #81A1C1
        magenta = [ 180 142 173 ]; #B48EAD
        cyan = [ 136 192 208 ]; #88C0D0
        white = [ 229 233 240 ]; #E5E9F0
        orange = [ 208 135 112 ]; #D08770
      };
      ui.pane_frames.rounded_corners = true;
    };
  };
}
