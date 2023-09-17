{
  local,
  home,
  launchd,
  ...
}: {
  home = {
    username = local.user;
    homeDirectory = "/Users/${local.user}";

    sessionVariables = {
      XDG_RUNTIME_DIR = "/Users/${local.user}/.local/run";
      SSH_AUTH_SOCK = "/Users/${local.user}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    file = {
      AquaSKK = {
        source = ./. + "/files/AquaSKK";
        target = "Library/Application Support/AquaSKK";
        recursive = true;
      };
    };

    stateVersion = "22.05";
  };

  launchd.agents = {
    muscat = {
      enable = true;
      config = {
        Label = "dev.warashi.muscat";
        ProgramArguments = ["/bin/sh" "-c" "$HOME/.local/bin/muscat server"];
        RunAtLoad = true;
        KeepAlive = true;
      };
    };
  };
}
