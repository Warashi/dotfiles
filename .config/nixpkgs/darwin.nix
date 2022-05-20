{ config, pkgs, ... }:

{
  # import home-manager
  imports = [ <home-manager/nix-darwin> ];

  # user config
  users.users.sawada = {
    name = "sawada";
    home = "/Users/sawada";
  };
  home-manager.useUserPackages = true;
  home-manager.users.sawada = { pkgs, ... }: {
    home.packages = import ./core-packages.nix { pkgs = pkgs; };
    imports = [ ./core-config.nix ];
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  programs.zsh.enable = true;

  # gpg-agent
  programs.gnupg.agent.enable = true;

  # autossh
  services.autossh.sessions = [{
    name = "workbench";
    user = "sawada";
    extraArguments = "-N forward-workbench";
    monitoringPort = 20000;
  }];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
