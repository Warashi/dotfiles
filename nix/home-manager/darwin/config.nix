{
  inputs,
  emacs,
  local,
  pkgs,
  ...
}: let
  yaskkserv2-dictionary = pkgs.runCommand "yaskkserv2-dictionary" {} ''
    ${pkgs.yaskkserv2}/bin/yaskkserv2_make_dictionary --dictionary-filename=$out ${inputs.skk-jisyo-L + "/SKK-JISYO.L"} ${inputs.skk-jisyo-jawiki + "/SKK-JISYO.jawiki"}
  '';
  muscat = pkgs.muscat {useGolangDesign = true;};
in {
  home = {
    username = local.user;
    homeDirectory = "/Users/${local.user}";

    sessionVariables = {
      SSH_AUTH_SOCK = "/Users/${local.user}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
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
    yaskkserv2 = {
      enable = true;
      config = {
        Label = "dev.warashi.yaskkserv2";
        ProgramArguments = [
          "${pkgs.yaskkserv2}/bin/yaskkserv2"
          "--no-daemonize"
          "--listen-address=127.0.0.1"
          "--google-japanese-input=disable"
          "${yaskkserv2-dictionary}"
        ];
        RunAtLoad = true;
        KeepAlive = true;
      };
    };
  };
}
