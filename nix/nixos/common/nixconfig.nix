{ pkgs, ... }:
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # ガベージコレクションを自動実行
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
    };
  };

  environment = {
    shells = with pkgs; [
      zsh
    ];
    systemPackages = with pkgs; [
      nix
    ];
  };

  nixpkgs.config.allowUnfree = true;
}
