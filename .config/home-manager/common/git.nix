{
  programs,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    includes = [
      {path = "~/.config/git/local";}
    ];
    aliases = {
      sw = "switch";
      sc = "switch -c";
      sch = ''! git fetch origin HEAD && git switch -c "$1" FETCH_HEAD; :'';
      identity = ''! git config user.name "$(git config user.$1.name)"; git config user.email "$(git config user.$1.email)"; git config user.signingkey "$(git config user.$1.signingkey)"; :'';
      delete-merged = "!git branch --merged | cut -c3- | xargs git branch -d";
      fo = ''! git fetch origin "$1:$1"; :'';
      psw = ''! git switch -d HEAD && (git fetch origin "$1:$1" && git switch - && git switch $1) || git switch -; :'';
      copr = ''! gh pr list | fzf-tmux -p 80% | awk '{ print $1 }' | xargs gh pr checkout'';
    };
    ignores = [
      (builtins.readFile ./files/gitignore)
    ];
    lfs = {
      enable = true;
    };
    extraConfig = {
      push.default = "simple";
      commit = {
        gpgsign = true;
        verbose = true;
      };
      gpg.format = "ssh";
      pull.ff = "only";
      init.defaultBranch = "main";
      fetch.prune = true;
      ghq.root = [
        "~/.local/share/sheldon/repos/"
        "~/.cache/nvim/dein/repos/"
        "~/ghq/"
      ];
      delta = {
        syntax-theme = "Catppuccin-latte";
        light = true;
        side-by-side = true;
        line-numbers = true;
        tabs = 2;
      };
      diff.colorMoved = "default";
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
  };
  programs.gh-dash = {
    enable = true;
    settings = {
      pager = {
        diff = "${pkgs.delta}/bin/delta";
      };
    };
  };
}
