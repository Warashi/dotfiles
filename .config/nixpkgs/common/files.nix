{home, ...}: {
  home.file.p10k = {
    target = ".config/zsh/.p10k.zsh";
    text = builtins.readFile ./files/p10k-config.zsh;
  };
}
