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
    home.packages = with pkgs; [
      exa
      fd
      fswatch
      gh
      ghq
      git
      go_1_18
      jq
      jump
      mas
      neovim
      neovim-remote
      pipenv
      reattach-to-user-namespace
      ripgrep
      skim
      starship
      tig
      tmux
    ];

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.home-manager.enable = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [];
  environment.shells = [ pkgs.fish ];
  environment.variables = {
    EDITOR = "nvim";
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

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
