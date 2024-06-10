_: {
  users = {
    users = {
      warashi = {
        isNormalUser = true;
        linger = true;
        autoSubUidGidRange = true;
        group = "warashi";
        extraGroups = [
          "docker"
        ];
      };
    };
    groups = {
      warashi = {};
    };
  };
}
