{home, ...}: {
  home.file.p10k = {
    target = "$HOME/.config/zsh/.p10k.zsh";
    text = builtins.readFile ./files/p10k-config.zsh;
  };
}
