_: {
  services = {
    flatpak = {
      enableModule = true;
      remotes = {
        "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      };
      packages = [
        "flathub:app/com.slack.Slack//stable"
        "flathub:app/com.discordapp.Discord//stable"
      ];
      overrides = {
        global = {
          environment = {
            MOZ_ENABLE_WAYLAND = 1;
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
          };
          sockets = [
            "wayland"
            "session-bus"
            "system-bus"
          ];
        };
      };
    };
  };
}
