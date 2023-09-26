{
  config,
  pkgs,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  time.timeZone = "Asia/Tokyo";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  console.enable = false;
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager = {
      gdm = {
        enable = true;
      };
    };
    desktopManager = {
      gnome = {
        enable = true;
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.warashi = {
    isNormalUser = true;
    description = "warashi";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [];

  system.stateVersion = "23.05"; # Did you read the comment?
}
