{
  inputs,
  local,
  home,
  pkgs,
  launchd,
  ...
}: let
  yaskkserv2-dictionary = pkgs.runCommand "yaskkserv2-dictionary" {} ''
    ${pkgs.yaskkserv2}/bin/yaskkserv2_make_dictionary --dictionary-filename=$out ${inputs.skk-jisyo-L + "/SKK-JISYO.L"} ${inputs.skk-jisyo-jawiki + "/SKK-JISYO.jawiki"}
  '';
in {
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