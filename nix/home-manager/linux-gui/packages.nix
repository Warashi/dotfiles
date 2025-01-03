{ pkgs, inputs, ... }:
let
  zed-editor-fhs = pkgs.buildFHSEnv {
    name = "zed";
    targetPkgs = pkgs: with pkgs; [ zed-editor ];
    runScript = "zed";
  };
in
{
  home.packages =
    (with pkgs; [
      code-cursor
      evince
      maestral-gui
      microsoft-edge
      muscat
      vscode
      xsel
    ])
    ++ [
      zed-editor-fhs

      inputs.ghostty.packages.${pkgs.hostPlatform.system}.default
    ];
}
