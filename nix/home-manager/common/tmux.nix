{
  programs,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "g";
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      tmux-thumbs
    ];
    extraConfig =
      builtins.readFile ./files/extra-config.tmux;
  };
}
