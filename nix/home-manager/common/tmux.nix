{ programs
, pkgs
, ...
}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "g";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      tmux-thumbs

      {
        plugin = tmux-1password;
        extraConfig = ''
          set -g @1password-vault 'terminal'
        '';
      }

      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'frappe'
          set -g @catppuccin_window_tabs_enabled on
        '';
      }
    ];
    extraConfig =
      builtins.readFile ./files/extra-config.tmux;
  };
}
