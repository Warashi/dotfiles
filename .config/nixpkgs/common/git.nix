{programs, ...}: {
  programs.git = {
    enable = true;
    includes = [
      {path = "~/.config/git/local";}
    ];
    difftastic = {
      enable = true;
      background = "dark";
    };
    aliases = {
      sw = "switch";
      sc = "switch -c";
      identity = ''! git config user.name "$(git config user.$1.name)"; git config user.email "$(git config user.$1.email)"; git config user.signingkey "$(git config user.$1.signingkey)"; :'';
      delete-merged = "!git branch --merged | cut -c3- | xargs git branch -d";
      fo = ''! git fetch origin "$1:$1"'';
      psw = ''! git switch -d HEAD && (git fetch origin "$1:$1" && git switch - && git switch $1) || git switch -; :'';
    };
    ignores = [
      (builtins.readFile ./files/gitignore)
    ];
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
      credential = {
        "https://github.com" = {
          helper = "!gh auth git-credential";
        };
        "https://gist.github.com" = {
          helper = "!gh auth git-credential";
        };
      };
    };
  };
}