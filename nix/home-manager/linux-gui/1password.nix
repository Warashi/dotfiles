_: {
  programs.zsh.initExtra = ''export SSH_AUTH_SOCK="''$HOME/.1password/agent.sock"'';
  xdg = {
    configFile = {
      _1password-gui-autostart = {
        text = ''
          [Desktop Entry]
          Name=1Password
          Type=Application
          Exec=1password --silent
          StartupWMClass=1Password
          Icon=1password
          Comment=Password manager and secure wallet
          Terminal=false
        '';
        target = "autostart/1password-gui.desktop";
      };
    };
  };
}
