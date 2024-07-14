{
  pkgs,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      window =
        {
          opacity = 1.0;
          padding = {
            x = 0;
            y = 0;
          };
        }
        // (lib.optionalAttrs pkgs.stdenv.isDarwin {
          option_as_alt = "Both";
        });
      scrolling = {
        history = 0;
      };
      font = {
        size = 13.0;
        normal = {
          family = "PlemolJP Console NF";
          style = "Regular";
        };
        bold = {
          family = "PlemolJP Console NF";
          style = "Bold";
        };
        italic = {
          family = "PlemolJP Console NF";
          style = "Regular Italic";
        };
        bold_italic = {
          family = "PlemolJP Console NF";
          style = "Bold Italic";
        };
      };
      keyboard.bindings =
        []
        ++ (lib.optionals pkgs.stdenv.isDarwin (
          let
            keys = lib.stringToCharacters "ABCDEFGHIJKLMNOPQRSTUVWXYZ[]=-0123456789" ++ ["NumpadAdd" "NumpadSubtract" "Tab"];
          in
            (lib.forEach keys (key: {
              key = key;
              mods = "Command";
              mode = "Alt";
              action = "ReceiveChar";
            }))
            ++ (lib.forEach keys (key: {
              key = key;
              mods = "Command|Alt";
              mode = "Alt";
              action = "ReceiveChar";
            }))
            ++ (lib.forEach keys (key: {
              key = key;
              mods = "Command|Control";
              mode = "Alt";
              action = "ReceiveChar";
            }))
            ++ (lib.forEach keys (key: {
              key = key;
              mods = "Command|Shift";
              mode = "Alt";
              action = "ReceiveChar";
            }))
        ));
    };
  };
}
