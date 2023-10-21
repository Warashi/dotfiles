{
  inputs,
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
    denops-shared-server = {
      # メモリリークっぽい挙動があるので一旦やめる
      enable = false;
      config = {
        Label = "dev.warashi.denops-shared-server";
        ProgramArguments = [
          "${pkgs.zsh}/bin/zsh"
          "-c"
          "source /etc/zshenv; source $HOME/.zshenv; ${pkgs.deno}/bin/deno run -A --no-lock ${inputs.denops-vim}/denops/@denops-private/cli.ts;"
        ];
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
