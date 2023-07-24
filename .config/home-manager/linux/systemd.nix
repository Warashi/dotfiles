{systemd, ...}: {
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
  };
}
