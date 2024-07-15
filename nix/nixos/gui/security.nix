_: {
  security = {
    polkit.enable = true;
    pam = {
      u2f = {
        enable = true;
        settings = {
          cue = true;
          origin = "ozashiki.warashi.dev";
        };
      };
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
        hyprlock.u2fAuth = true;
      };
    };
  };
}
