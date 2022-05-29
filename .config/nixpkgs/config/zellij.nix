{ programs, pkgs, ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      default_mode = "locked";
      copy_command = "muscat copy";
      theme = "solarized";
      themes = {
        solarized = {
          fg = [ 253 246 227 ];
          bg = [ 0 43 54 ];
          black = [ 7 54 66 ];
          red = [ 220 50 47 ];
          green = [ 133 153 0 ];
          yellow = [ 181 137 0 ];
          blue = [ 38 139 210 ];
          magenta = [ 211 54 130 ];
          cyan = [ 42 161 152 ];
          white = [ 238 232 213 ];
          orange = [ 203 75 22 ];
        };
        nord = {
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
      };
      ui.pane_frames.rounded_corners = true;

      keybinds = {
        unbind = true;
        locked = [
          { key = [{ Ctrl = "g"; }]; action = [{ SwitchToMode = "Normal"; }]; }
        ];
        normal = [
          { key = [{ Char = "p"; }]; action = [{ SwitchToMode = "Pane"; }]; }
          { key = [{ Char = "n"; }]; action = [{ SwitchToMode = "Resize"; }]; }
          { key = [{ Char = "t"; }]; action = [{ SwitchToMode = "Tab"; }]; }
          { key = [{ Char = "s"; }]; action = [{ SwitchToMode = "Scroll"; }]; }
          { key = [{ Char = "o"; }]; action = [{ SwitchToMode = "Session"; }]; }
          { key = [{ Char = "h"; }]; action = [{ SwitchToMode = "Move"; }]; }
          { key = [{ Ctrl = "g"; } { Char = "\n"; } "Esc"]; action = [{ SwitchToMode = "Locked"; }]; }
        ];
        pane = [
          { key = [{ Char = "h"; }]; action = [{ MoveFocus = "Left"; }]; }
          { key = [{ Char = "j"; }]; action = [{ MoveFocus = "Down"; }]; }
          { key = [{ Char = "k"; }]; action = [{ MoveFocus = "Up"; }]; }
          { key = [{ Char = "l"; }]; action = [{ MoveFocus = "Right"; }]; }
          { key = [{ Char = "n"; }]; action = [{ NewPane = null; }]; }
          { key = [{ Char = "x"; }]; action = [ "CloseFocus" ]; }
          { key = [{ Char = "f"; }]; action = [ "ToggleFocusFullscreen" ]; }
          { key = [{ Ctrl = "g"; } { Char = "\n"; } "Esc"]; action = [{ SwitchToMode = "Locked"; }]; }
        ];
        resize = [
          { key = [{ Char = "h"; }]; action = [{ Resize = "Left"; }]; }
          { key = [{ Char = "j"; }]; action = [{ Resize = "Down"; }]; }
          { key = [{ Char = "k"; }]; action = [{ Resize = "Up"; }]; }
          { key = [{ Char = "l"; }]; action = [{ Resize = "Right"; }]; }
          { key = [{ Ctrl = "g"; } { Char = "\n"; } "Esc"]; action = [{ SwitchToMode = "Locked"; }]; }
        ];
        tab = [
          { key = [{ Char = "h"; } { Char = "k"; }]; action = [ "GoToPreviousTab" ]; }
          { key = [{ Char = "l"; } { Char = "j"; }]; action = [ "GoToNextTab" ]; }
          { key = [{ Char = "n"; }]; action = [{ NewTab = null; }]; }
          { key = [{ Char = "x"; }]; action = [{ CloseTab = null; }]; }
          { key = [{ Ctrl = "g"; } { Char = "\n"; } "Esc"]; action = [{ SwitchToMode = "Locked"; }]; }
        ];
        scroll = [
          { key = [{ Char = "j"; }]; action = [ "ScrollDown" ]; }
          { key = [{ Char = "k"; }]; action = [ "ScrollUp" ]; }
          { key = [{ Ctrl = "d"; }]; action = [ "HalfPageScrollDown" ]; }
          { key = [{ Ctrl = "u"; }]; action = [ "HalfPageScrollUp" ]; }
          { key = [{ Ctrl = "g"; } { Char = "\n"; } "Esc"]; action = [{ SwitchToMode = "Locked"; }]; }
        ];
        session = [
          { key = [{ Char = "d"; }]; action = [ "Detach" ]; }
          { key = [{ Ctrl = "g"; } { Char = "\n"; } "Esc"]; action = [{ SwitchToMode = "Locked"; }]; }
        ];
        move = [
          { key = [{ Char = "h"; }]; action = [{ MovePane = "Left"; }]; }
          { key = [{ Char = "j"; }]; action = [{ MovePane = "Down"; }]; }
          { key = [{ Char = "k"; }]; action = [{ MovePane = "Up"; }]; }
          { key = [{ Char = "l"; }]; action = [{ MovePane = "Right"; }]; }
          { key = [{ Ctrl = "g"; } { Char = "\n"; } "Esc"]; action = [{ SwitchToMode = "Locked"; }]; }
        ];
      };
    };
  };
}
