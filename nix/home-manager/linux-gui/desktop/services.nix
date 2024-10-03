{ inputs, ... }:
{
  services = {
    status-notifier-watcher = {
      enable = true;
    };
  };
}
