_:
let
  catppuccin-frappe-blue = {
    activeBorderColor = [ "#8caaee" "bold" ];
    inactiveBorderColor = [ "#a5adce" ];
    optionsTextColor = [ "#8caaee" ];
    selectedLineBgColor = [ "#414559" ];
    selectedRangeBgColor = [ "#414559" ];
    cherryPickedCommitBgColor = [ "#51576d" ];
    cherryPickedCommitFgColor = [ "#8caaee" ];
    unstagedChangesColor = [ "#e78284" ];
    defaultFgColor = [ "#c6d0f5" ];
    searchingActiveBorderColor = [ "#e5c890" ];
  };
in
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = "3";
        theme = catppuccin-frappe-blue;
      };
      git = {
        autoFetch = false;
        autoRefresh = false;
        fetchAll = false;
        disableForcePushing = true;
        parseEmoji = true;
      };
      update = {
        method = "never";
      };
      confirmOnQuit = true;
      disableStartupPopups = true;
      notARepository = "quit";
    };
  };
}
