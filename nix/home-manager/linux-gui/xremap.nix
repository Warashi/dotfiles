_: {
  services.xremap = {
    withX11 = true;
    config = {
      modmap = [
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
      ];
    };
  };
}
