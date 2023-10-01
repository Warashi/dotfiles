_: {
  services.xremap = {
    withX11 = true;
    config = {
      modmap = [
        {
          name = "Change Alt_L and Super_L";
          remap = {
            Alt_L = "Super_L";
            Super_L = "Alt_L";
          };
        }
        {
          name = "CapsLock to Ctrl_R and Escape";
          remap = {
            CapsLock = {
              held = "Ctrl_L";
              alone = "Esc";
            };
          };
        }
        {
          name = "SandS";
          remap = {
            Space = {
              held = "Shift_R";
              alone = "Space";
            };
          };
        }
        {
          name = "Tab to meh(Shift+Control+Alt) and Tab";
          remap = {
            Tab = {
              held = ["Shift_R" "Ctrl_R" "Alt_R"];
              alone = "Tab";
            };
          };
        }
      ];
      keymap = [
        {
          name = "Shift_L + h/j/k/l to Arrows";
          remap = {
            Shift_L-h = "left";
            Shift_L-j = "down";
            Shift_L-k = "up";
            Shift_L-l = "right";
          };
        }
        {
          name = "Emacs emulation";
          remap = {
            Ctrl_L-a = "home";
            Ctrl_L-b = "left";
            Ctrl_L-d = "delete";
            Ctrl_L-e = "end";
            Ctrl_L-f = "right";
            Ctrl_L-h = "backspace";
            Ctrl_L-k = ["Shift_R-end" "delete"];
            Ctrl_L-n = "down";
            Ctrl_L-p = "up";
          };
          application = {
            not = ["Alacritty"];
          };
        }
        {
          name = "macOS enulation";
          remap = {
            Super-a = "Ctrl_R-a";
            Super-f = "Ctrl_R-f";
            Super-h = "Ctrl_R-h";
            Super-l = "Ctrl_R-l";
            Super-q = "Ctrl_R-q";
            Super-t = "Ctrl_R-t";
            Super-w = "Ctrl_R-w";
            Super-LeftBrace = "Ctrl_R-LeftBrace";
            Super-RightBrace = "Ctrl_R-RightBrace";
          };
        }
      ];
    };
  };
}
