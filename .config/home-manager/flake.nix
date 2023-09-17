{
  description = "Home Manager configuration of sawada";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    skk-jisyo-L = {
      url = "github:skk-dev/dict";
      flake = false;
    };
    skk-jisyo-jawiki = {
      url = "github:tokuhirom/jawiki-kana-kanji-dict";
      flake = false;
    };
    bat-catppuccin-latte = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-zsh-fsh = {
      url = "github:catppuccin/zsh-fsh?dir=themes";
      flake = false;
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    local = import ./local.nix;
    inherit (local) system;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.${local.user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules =
        [
          ./common/overlays.nix

          ./common/config.nix
          ./common/packages.nix

          ./common/alacritty.nix
          ./common/direnv.nix
          ./common/files.nix
          ./common/git.nix
          ./common/tmux.nix

          ./common/zsh/config.nix
          ./common/zsh/zcompile-rcs.nix
        ]
        ++ (
          if local.hasGUI
          then []
          else []
        )
        ++ (
          if local.isDarwin
          then [
            ./darwin/config.nix
            ./darwin/packages.nix
          ]
          else [
            ./linux/config.nix
            ./linux/packages.nix
            ./linux/systemd.nix
          ]
        );

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {inherit inputs local;};
    };
  };
}
