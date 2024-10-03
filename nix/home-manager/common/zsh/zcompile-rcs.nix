{
  config,
  home,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.zsh;
  relToDotDir = file: (lib.optionalString (cfg.dotDir != null) (cfg.dotDir + "/")) + file;
  zcompile =
    file:
    pkgs.runCommand "${file}.zwc" { } ''
      cat <<'EOF' > ${file}
      ${config.home.file."${relToDotDir "${file}"}".text}
      EOF
      ${pkgs.zsh}/bin/zsh -c "zcompile -R ${file}"
      cp ${file}.zwc $out
    '';
in
{
  home.file = {
    "${relToDotDir ".zshrc.zwc"}".source = zcompile ".zshrc";
    "${relToDotDir ".zshenv.zwc"}".source = zcompile ".zshenv";
  };
}
