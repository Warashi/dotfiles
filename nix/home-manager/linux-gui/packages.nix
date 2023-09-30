{pkgs, ...}: {
  home.packages = with pkgs; [
    (_1password-gui.override {
      polkitPolicyOwners = ["warashi"];
    })
    firefox
    muscat
  ];
}
