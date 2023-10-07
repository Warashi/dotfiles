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
    # neovim = {
    #   Unit = {
    #     Description = "neovim text editor";
    #     Documentation = "man:nvim(1)";
    #   };
    #   Service = {
    #     ExecStart = ''${pkgs.zsh}/bin/zsh -c ". /etc/zshrc; exec ${pkgs.neovim}/bin/nvim --headless --listen ${builtins.getEnv "XDG_RUNTIME_DIR"}/nvim.socket"'';
    #     ExecStop = ''${pkgs.neovim}/bin/nvim --server ${builtins.getEnv "XDG_RUNTIME_DIR"}/nvim.socket --remote-send "<C-\><C-N>:wqa<CR>"'';
    #     Restart = ''always'';
    #   };
    # };
    denops-shared-server = {
      Unit = {
        Description = "Denops shared server";
        Documentation = "";
      };
      Service = {
        ExecStart = ''${pkgs.deno}/bin/deno run -A --no-lock ${inputs.denops-vim}/denops/@denops-private/cli.ts'';
        Restart = ''always'';
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
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
