{
  programs,
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "g";
    terminal = "screen-256color";
    sensibleOnTop = false;
    plugins = with pkgs.tmuxPlugins; [
    ];
    extraConfig = builtins.readFile ./files/extra-config.tmux;
  };
}
