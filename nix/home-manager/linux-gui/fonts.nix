{pkgs, ...}: let
  plemoljp = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "plemoljp-console-nf";
    version = "1.6.0";

    src = fetchzip {
      url = "https://github.com/yuru7/PlemolJP/releases/download/v${version}/PlemolJP_NF_v${version}.zip";
      hash = "0z7w0hmx38azs8p34kvhipg3w024aq9pw4b1wrw59acydg5gz1q1";
    };

    installPhase = ''
      runHook preInstall

      install -Dm644 PlemolJPConsole_NF/*.ttf -t $out/share/fonts/truetype

      runHook postInstall
    '';
  };
in {
  fonts.fontconfig.enable = true;
  home.packages = [plemoljp];
}
