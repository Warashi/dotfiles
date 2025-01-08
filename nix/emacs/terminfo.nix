{ inputs,  ... }: {
  home.file.".terminfo/e" = {
    recursive = true;
    source = inputs.emacs-src + /etc/e;
  };
}
