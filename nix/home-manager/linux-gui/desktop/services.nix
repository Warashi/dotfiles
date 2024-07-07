{inputs, ...}: {
  services = {
    status-notifier-watcher = {
      enable = true;
    };
    dunst = {
      enable = true;
      configFile = inputs.catppuccin-dunst + "/src/latte.conf";
    };
  };
}
