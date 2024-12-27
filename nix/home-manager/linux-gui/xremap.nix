_: {
  services.xremap = {
    withKDE = true;
    config = {
      keypress_delay_ms = 20;
      modmap = [
        {
          name = "modify alt_l/alt_r/super_l";
          remap = {
            Super_L = "Alt_L";
            Alt_L = {
              held = "Super_L";
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
              held = [
                "Shift_R"
                "Ctrl_R"
                "Alt_R"
              ];
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
            not = [
              "Alacritty"
              "Code"
              "Emacs"
              "emacs"
              "foot"
              "footclient"
              "dev.zed.Zed"
            ];
          };
          remap = {
            Ctrl_L-a = "home";
            Ctrl_L-b = "left";
            Ctrl_L-d = "delete";
            Ctrl_L-e = "end";
            Ctrl_L-f = "right";
            Ctrl_L-h = "backspace";
            Ctrl_L-k = [
              "Shift_R-end"
              "delete"
            ];
            Ctrl_L-n = "down";
            Ctrl_L-p = "up";
          };
        }
        {
          name = "macOS enulation";
          application = {
            not = [
              "Alacritty"
              "Code"
              "Emacs"
              "emacs"
              "foot"
              "footclient"
              "dev.zed.Zed"
            ];
          };
          exact_match = true;
          remap = {
            Super-0 = "Ctrl_R-0";
            Super-1 = "Ctrl_R-1";
            Super-2 = "Ctrl_R-2";
            Super-3 = "Ctrl_R-3";
            Super-4 = "Ctrl_R-4";
            Super-5 = "Ctrl_R-5";
            Super-6 = "Ctrl_R-6";
            Super-7 = "Ctrl_R-7";
            Super-8 = "Ctrl_R-8";
            Super-9 = "Ctrl_R-9";
            Super-a = "Ctrl_R-a";
            Super-c = "Ctrl_R-c";
            Super-d = "Ctrl_R-d";
            Super-f = "Ctrl_R-f";
            Super-h = "Ctrl_R-h";
            Super-k = "Ctrl_R-k";
            Super-l = "Ctrl_R-l";
            Super-o = "Ctrl_R-o";
            Super-q = "Ctrl_R-q";
            Super-r = "Ctrl_R-r";
            Super-t = "Ctrl_R-t";
            Super-v = "Ctrl_R-v";
            Super-w = "Ctrl_R-w";
            Super-x = "Ctrl_R-x";
            Super-z = "Ctrl_R-z";

            Super-LeftBrace = "Ctrl_R-LeftBrace";
            Super-RightBrace = "Ctrl_R-RightBrace";
          };
        }
      ];
    };
  };
}
