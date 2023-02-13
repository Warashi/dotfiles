{
  systemd,
  pkgs,
  ...
}: {
  systemd.user.services = {
    neovim = {
      Unit = {
        Description = "neovim text editor";
        Documentation = "man:nvim(1)";
      };
      Service = {
        ExecStart = ''${pkgs.zsh}/bin/zsh -c ". /etc/zshrc; exec ${pkgs.neovim}/bin/nvim --headless --listen ${builtins.getEnv "XDG_RUNTIME_DIR"}/nvim.socket"'';
        ExecStop = ''${pkgs.neovim}/bin/nvim --server ${builtins.getEnv "XDG_RUNTIME_DIR"}/nvim.socket --remote-send "<C-\><C-N>:wqa<CR>"'';
        Restart = ''always'';
      };
    };
    eternal-terminal = {
      Unit = {
        Description = "Eternal Terminal server.";
        After = ["syslog.target" "network.target"];
      };
      Install = {
        WantedBy = ["multi-user.target"];
      };
      Service = {
        Type = "forking";
        ExecStart = "${pkgs.eternal-terminal}/bin/etserver --pidfile ${builtins.getEnv "XDG_RUNTIME_DIR"}/etserver.pid --daemon --cfgfile=${pkgs.writeText "et.cfg" ''
          ; et.cfg : Config file for Eternal Terminal
          ;
          [Networking]
          port = 2022
          [Debug]
          verbose = 0
          silent = 0
          logsize = 20971520
        ''}";
        Restart = "on-failure";
        KillMode = "process";
      };
    };
  };
}
