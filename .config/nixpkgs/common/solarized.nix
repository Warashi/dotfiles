let
  solarized = {
    base03 = [0 43 54]; #002b36
    base02 = [7 54 66]; #073642
    base01 = [88 110 117]; #586e75
    base00 = [101 123 131]; #657b83
    base0 = [131 148 150]; #839496
    base1 = [147 161 161]; #93a1a1
    base2 = [238 232 213]; # eee8d5
    base3 = [253 246 227]; #fdf6e3
    yellow = [181 137 0]; #b58900
    orange = [203 75 22]; #cb4b16
    red = [220 50 47]; #dc322f
    magenta = [211 54 130]; #d33682
    violet = [108 113 196]; #6c71c4
    blue = [38 139 210]; #268b2d
    cyan = [42 161 152]; #2aa198
    green = [133 153 0]; #859900
  };
in {
  dark = {
    fg = solarized.base0;
    bg = solarized.base03;
    white = solarized.base2;
    black = solarized.base01;
    red = solarized.red;
    green = solarized.green;
    yellow = solarized.yellow;
    blue = solarized.blue;
    magenta = solarized.magenta;
    cyan = solarized.cyan;
    orange = solarized.orange;
    violet = solarized.violet;
  };
  light = {
    fg = solarized.base00;
    bg = solarized.base3;
    white = solarized.base2;
    black = solarized.base01;
    red = solarized.red;
    green = solarized.green;
    yellow = solarized.yellow;
    blue = solarized.blue;
    magenta = solarized.magenta;
    cyan = solarized.cyan;
    orange = solarized.orange;
    violet = solarized.violet;
  };
}
