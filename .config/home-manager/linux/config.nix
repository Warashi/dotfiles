{
  pkgs,
  home,
  ...
}: let
  local = import ../local.nix;
in {
  imports = [
    ../common/config.nix
    ./systemd.nix
  ];

  home.username = local.user;
  home.homeDirectory = "/home/${local.user}";
  home.packages =
    import ./packages.nix {inherit pkgs;}
    ++ import ../common/packages.nix {inherit pkgs;};

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
