{emacs, ...}: {
  services = {
    emacs = {
      enable = true;
      client.enable = true;
      defaultEditor = true;

      package = emacs.package;
    };
  };
}
