{pkgs, ...}: {
  home.packages = with pkgs; [
    ((muscat {}).overrideAttrs
      (_: {
        postInstall = ''
          cd $out/bin
          for link in lemonade pbcopy pbpaste xdg-open; do
            ln -s muscat $link
          done
        '';
      }))
  ];
}
