{
  inputs,
  pkgs,
  ...
}: let
  yaskkserv2-dictionary = pkgs.runCommand "yaskkserv2-dictionary" {} ''
    ${pkgs.yaskkserv2}/bin/yaskkserv2_make_dictionary --dictionary-filename=$out ${inputs.skk-jisyo-L + "/SKK-JISYO.L"} ${inputs.skk-jisyo-jawiki + "/SKK-JISYO.jawiki"}
  '';
in {
  systemd.user.services = {
    yaskkserv2 = {
      Unit = {
        Description = "Yet Another SKK Server";
        Documentation = "";
      };
      Service = {
        ExecStart = ''${pkgs.yaskkserv2}/bin/yaskkserv2 --no-daemonize --listen-address=127.0.0.1 --google-japanese-input=disable ${yaskkserv2-dictionary}'';
        Restart = ''always'';
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
