_:
let
  catppuccin-latte-blue = {
    activeBorderColor = [ "#1e66f5" "bold" ];
    inactiveBorderColor = [ "#6c6f85" ];
    optionsTextColor = [ "#1e66f5" ];
    selectedLineBgColor = [ "#ccd0da" ];
    selectedRangeBgColor = [ "#ccd0da" ];
    cherryPickedCommitBgColor = [ "#bcc0cc" ];
    cherryPickedCommitFgColor = [ "#1e66f5" ];
    unstagedChangesColor = [ "#d20f39" ];
    defaultFgColor = [ "#4c4f69" ];
    searchingActiveBorderColor = [ "#df8e1d" ];
  };
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
        theme = catppuccin-latte-blue;
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
