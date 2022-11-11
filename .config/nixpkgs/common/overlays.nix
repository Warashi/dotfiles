[
  # (import (builtins.fetchTarball {
  #   url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
  # }))
  (_: prev: {
    yabai = prev.yabai.overrideAttrs (_: {
      version = "5.0.1";
      src = prev.fetchurl {
        url = "https://github.com/koekeishiya/yabai/releases/download/v5.0.1/yabai-v5.0.1.tar.gz";
        sha256 = "0czxhf95mnpycbp7aqz9ajgnb0zmazdh9lhj14gn4kpnwj64kwmd";
      };
      buildPhase = ''
        echo noop
      '';
    });
  })
]
