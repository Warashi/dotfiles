{home, ...}: {
  home.file = {
    cspel = {
      target = ".config/cspell/cspell.json";
      source = ./. + "/files/cspell.json";
    };
    nvredit = {
      target = ".local/bin/nvredit";
      source = ./. + "/files/nvredit";
      executable = true;
    };
    rgfind = {
      target = ".local/bin/rgfind";
      source = ./. + "/files/rgfind";
      executable = true;
    };
    p10k = {
      target = ".config/zsh/.p10k.zsh";
      source = ./. + "/files/p10k-config.zsh";
    };
    rg = {
      target = ".config/ripgrep/config";
      text = ''
        --hidden
        --glob=!.git/
      '';
    };
    oj-template = {
      target = ".config/online-judge-tools/template/main.go";
      text = ''
        package main

        import "github.com/Warashi/go-atcoder/lib/myio"

        func main() {
        	defer myio.Flush()

        }
      '';
    };
    largedict = {
      source = builtins.fetchurl "https://github.com/skk-dev/dict/raw/master/SKK-JISYO.L";
      target = ".config/skk/SKK-JISYO.L";
    };
    wikidict = {
      source = builtins.fetchurl "https://github.com/tokuhirom/skk-jisyo-jawiki/raw/master/SKK-JISYO.jawiki";
      target = ".config/skk/SKK-JISYO.jawiki";
    };
  };
}
