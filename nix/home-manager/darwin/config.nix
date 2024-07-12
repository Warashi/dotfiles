{
  inputs,
  emacs,
  local,
  pkgs,
  ...
}: let
  muscat = pkgs.muscat.override {useGolangDesign = true;};
in {
  home = {
    username = local.user;
    homeDirectory = "/Users/${local.user}";

    sessionVariables = {
      SSH_AUTH_SOCK = "/Users/${local.user}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    shellAliases = {
      emacs = "$HOME/Applications/'Home Manager Apps'/Emacs.app/Contents/MacOS/Emacs";
    };

    stateVersion = "22.05";
  };

  launchd.agents = {
    emacs-daemon = {
      enable = false; # Emacs.app の方で起動する
      config = {
        Label = "dev.warashi.emacs";
        ProgramArguments = [
          "${emacs.package}/Applications/Emacs.app/Contents/MacOS/Emacs"
          "--fg-daemon"
        ];
        StandardOutPath = "/tmp/emacs-daemon.stdout.log";
        StandardErrorPath = "/tmp/emacs-daemon.stderr.log";
        RunAtLoad = true;
        KeepAlive = true;
      };
    };
    muscat = {
      enable = true;
      config = {
        Label = "dev.warashi.muscat";
        ProgramArguments = ["${muscat}/bin/muscat" "server"];
        RunAtLoad = true;
        KeepAlive = true;
      };
    };
  };
}
