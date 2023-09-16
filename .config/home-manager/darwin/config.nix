{
  config,
  pkgs,
  ...
}: let
  local = import ../local.nix;
in {
  home.username = local.user;
  home.homeDirectory = "/Users/${local.user}";

  home.sessionVariables = {
    XDG_RUNTIME_DIR = "/Users/${local.user}/.local/run";
    SSH_AUTH_SOCK = "/Users/${local.user}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };

  home.packages =
    import ./packages.nix {inherit pkgs;}
    ++ import ../common/packages.nix {inherit pkgs;};

  home.file = {
    AquaSKK = {
      source = ./. + "/files/AquaSKK";
      target = "Library/Application Support/AquaSKK";
      recursive = true;
    };
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

  home.stateVersion = "22.05";
}
