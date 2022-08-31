{ nixpkgs, config, pkgs, ... }: {
  # user config
  users.users.sawada = {
    name = "sawada";
    home = "/Users/sawada";
    shell = pkgs.zsh;
  };

  home-manager.users.sawada = { pkgs, ... }: {
    home.packages =
      import ./darwin-packages.nix { pkgs = pkgs; }
      ++ import ./core-packages.nix { pkgs = pkgs; };
    imports = [ ./core-config.nix ];

    home.stateVersion = "22.05";
  };

  services.autossh.sessions = [{
    name = "workbench";
    user = "sawada";
    extraArguments = "-N forward-workbench";
    monitoringPort = 20000;
  }];
}
