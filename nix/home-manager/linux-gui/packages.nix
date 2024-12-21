{ pkgs, ... }:
let
  zed-editor-fhs = pkgs.buildFHSEnv {
    name = "zed";
    targetPkgs = pkgs: with pkgs; [ zed-editor ];
    runScript = "zed";
  };
in
{
  home.packages = with pkgs; [
    evince
    maestral-gui
    vscode
    xsel
    zed-editor-fhs

    (muscat.override { useGolangDesign = true; })
  ];
}
