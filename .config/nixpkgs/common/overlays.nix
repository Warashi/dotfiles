[
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
    mosh =
      prev.mosh.overrideAttrs
      (attrs: {
        version = "1.4.0-pre.1";
        src = prev.fetchFromGitHub {
          owner = "mobile-shell";
          repo = prev.mosh.pname;
          rev = "135a11a2bb148beea93de24a835adef0cfe7a539";
          sha256 = "1qqvh5a62qcwa89b79ba0q4qw44674b8n4xvnjk1jzhyvbq9d1jz";
        };
        patches = [
          (prev.fetchpatch {
            name = "ssh_path.patch";
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/tools/networking/mosh/ssh_path.patch";
            sha256 = "uv3dTWUGvjW+NLaqMxcHfN8X5VOXpL6MmlDyrFQMuho=";
          })
          (prev.fetchpatch {
            name = "mosh-client_path.patch";
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/tools/networking/mosh/mosh-client_path.patch";
            sha256 = "i1Fbjq9iUigYIlvs664LER1FD3bnxyVz+NDo0FRmhBI=";
          })
          (prev.fetchpatch {
            name = "utempter_path.patch";
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/tools/networking/mosh/utempter_path.patch";
            sha256 = "f1vFOZB7kRcU8EIidato/l9plK+BqyFkZKAfDW4D+2E=";
          })
          (prev.fetchpatch {
            name = "bash_completion_datadir.patch";
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/tools/networking/mosh/bash_completion_datadir.patch";
            sha256 = "fHLmlZzilJBnNQflaPdIccoQWftI0tV+BdMY+MeYYRI=";
          })
        ];
        postPatch = ''
          substituteInPlace scripts/mosh.pl \
            --subst-var-by ssh "${prev.openssh}/bin/ssh" \
            --subst-var-by mosh-client "$out/bin/mosh-client"
        '';
      });
  })
]
