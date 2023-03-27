{
  programs,
  pkgs,
  ...
}: let
  warashiPkgs = import <warashi> {};
in {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "g";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      tmux-thumbs

      {
        plugin = warashiPkgs.tmux-catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'latte'
          set -g @catppuccin_window_tabs_enabled on
        '';
      }
    ];
    extraConfig =
      builtins.readFile ./files/extra-config.tmux;
  };
}
