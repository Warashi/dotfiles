_: {
  services.xremap = {
    withX11 = true;
    config = {
      modmap = [
        {
          name = "CapsLock to Ctrl_L";
          remap = {
            CapsLock = "Ctrl_L";
          };
        }
      ];
    };
  };
}
