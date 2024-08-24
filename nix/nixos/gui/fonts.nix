{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      plemoljp
      plemoljp-nf
    ];

    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
        sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
        monospace = ["PlemolJP Console NF" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
