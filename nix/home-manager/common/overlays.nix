{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    (_: _: {
      muscat = inputs.muscat.packages.${pkgs.hostPlatform.system}.default;
    })
  ];
}
