_: let
  local = import ./local.nix;
in {
  imports =
    [./common/config.nix]
    ++ (
      if local.isDarwin
      then [./darwin/config.nix]
      else [./linux/config.nix]
    );
}
