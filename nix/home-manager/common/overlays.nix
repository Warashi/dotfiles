{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (_: _: {
      muscat = inputs.muscat.packages.${pkgs.hostPlatform.system}.default;
    })
    (_: prev: {
      sheldon =
        if prev.stdenv.isDarwin
        then
          prev.sheldon.overrideAttrs (_: {
            doCheck = false;
            meta.platforms = prev.lib.platforms.unix;
          })
        else prev.sheldon;
    })
  ];
}
