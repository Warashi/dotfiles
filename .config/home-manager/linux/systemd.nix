{
  config,
  systemd,
  pkgs,
  ...
}: {
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
    yaskkserv2 = {
      Unit = {
        Description = "Yet Another SKK Server";
        Documentation = "";
      };
      Service = {
        ExecStart = ''${pkgs.yaskkserv2}/bin/yaskkserv2 --no-daemonize --listen-address=127.0.0.1 --google-japanese-input=disable ${config.home.homeDirectory}/.config/skk/dictionary.yaskkserv2'';
        Restart = ''always'';
      };
    };
  };
}
