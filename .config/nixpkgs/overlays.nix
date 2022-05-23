{ nixpkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      yabai = prev.yabai.overrideAttrs (attrs: {
        version = "4.0.1";
        src = prev.fetchurl {
          url = "https://github.com/koekeishiya/yabai/releases/download/v4.0.1/yabai-v4.0.1.tar.gz";
          sha256 = "sha256-UFtPBftcBytzvrELOjE4vPCKc3CCaA4bpqusok5sUMU=";
        };
        buildPhase = ''
          echo noop
        '';
      });
    })
  ];
}
