_: {
  services = {
    flatpak = {
      enableModule = true;
      remotes = {
        "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      };
      packages = [
        "flathub:app/com.slack.Slack//stable"
      ];
    };
  };
}
