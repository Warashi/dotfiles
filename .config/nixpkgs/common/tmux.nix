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

      warashiPkgs.tmux-catppuccin
    ];
    extraConfig =
      builtins.readFile ./files/extra-config.tmux;
  };
}
