{home, ...}: {
  home.file.nvredit = {
    target = ".local/bin/nvredit";
    source = ./. + "/files/nvredit";
    executable = true;
  };
  home.file.rgfind = {
    target = ".local/bin/rgfind";
    source = ./. + "/files/rgfind";
    executable = true;
  };
  home.file.p10k = {
    target = ".config/zsh/.p10k.zsh";
    source = ./. + "/files/p10k-config.zsh";
  };
  home.file.rg = {
    target = ".config/ripgrep/config";
    text = ''
      --hidden
      --glob=!.git/
    '';
  };
  home.file.oj-template = {
    target = ".config/online-judge-tools/template/main.go";
    text = ''
      package main

      import "github.com/Warashi/go-atcoder/lib/myio"

      func main() {
      	defer myio.Flush()

      }
    '';
  };
}
