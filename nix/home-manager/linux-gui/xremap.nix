_: {
  services.xremap = {
    withWlroots = true;
    config = {
      keypress_delay_ms = 20;
      modmap = [
        {
          name = "Left/Right alt to japanese_eisuu/japanese_kana";
          remap = {
            Alt_L = {
              held = "Alt_L";
              alone = "Muhenkan";
            };
            Alt_R = {
              held = "Alt_R";
              alone = "Henkan";
            };
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
          application = {
            not = ["Alacritty" "Emacs"];
          };
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
        }
      ];
    };
  };
}
