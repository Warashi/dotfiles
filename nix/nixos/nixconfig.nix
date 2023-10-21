_: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
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

  nixpkgs.config.allowUnfree = true;
}
