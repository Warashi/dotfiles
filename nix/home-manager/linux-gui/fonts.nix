{pkgs, ...}: let
  plemoljp = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "plemoljp-console-nf";
    version = "1.6.0";

    src = pkgs.fetchzip {
      url = "https://github.com/yuru7/PlemolJP/releases/download/v${version}/PlemolJP_NF_v${version}.zip";
      hash = "sha256-AYf/ymueqVR45mERfhNWRAA+3o1wTzIu0l+h0SsE/Hw=";
    };

    installPhase = ''
      runHook preInstall

      install -Dm644 PlemolJPConsole_NF/*.ttf -t $out/share/fonts/truetype

      runHook postInstall
    '';
  };
in {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    plemoljp

    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
  ];
}
