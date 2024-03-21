{pkgs, ...}: {
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    sessionPath =
      [
        "$HOME/.local/bin"
        "$HOME/go/bin"
      ]
      ++ (
        if pkgs.stdenv.isDarwin
        then ["/opt/homebrew/bin"]
        else []
      );

    sessionVariables = {
      DENO_NO_UPDATE_CHECK = "1";
      EDITOR = "nvim --noplugin";
      KEYTIMEOUT = "1";
      LANG = "en_US.UTF-8";
      MANPAGER = "nvim +Man!";
      LS_COLORS = "$(${pkgs.vivid}/bin/vivid generate catppuccin-latte)";
      MOCWORD_DATA = "${pkgs.mocword-data}/mocword.sqlite";

      # zeno config
      ZENO_HOME = "$HOME/.config/zeno";
      ZENO_ENABLE_FZF_TMUX = "1";
      ZENO_FZF_TMUX_OPTIONS = "-p 80%";
      ZENO_ENABLE_SOCK = "1";
      ZENO_GIT_CAT = "bat --color=always";
      ZENO_GIT_TREE = "eza --tree";
    };

    shellAliases = {
      e = "emacsclient -t -a ''";
      v = "nvim --noplugin";
      g = "git";
      k = "kubectl";
      kx = "kubectx";
      ":q" = "exit";
      lg = "lazygit";
      zl = "zk lazygit";
      zn = "zk new";
      zz = "zk amend";
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    bash = {
      enable = true;
      initExtra = "unset -f which";
    };

    bat = {
      enable = true;
      config = {
        theme = "Catppuccin-latte";
        wrap = "never";
        pager = "${pkgs.ov}/bin/ov --quit-if-one-screen -H3 --section-header";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = false;
      defaultOptions = [
        "--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39,fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78,marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39" # catppuccin-latte
        # "--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284,fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf,marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284" # catppuccin-frappe
        # "--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796,fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6,marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796" # catppuccin-macchiato
        # "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8" # catppuccin-mocha
      ];
      tmux.enableShellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = false;
      options = ["--cmd j"];
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--hidden"
        "--glob=!.git/"
      ];
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
    };

    emacs-twist = {
      enable = true;
    };
  };
}
