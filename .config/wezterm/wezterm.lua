local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

wezterm.on("trigger-password-input", function(window, pane)
  local choices = {
    { label = "local" },
    { label = "remote" },
  }
  window:perform_action(
    act.InputSelector({
      action = wezterm.action_callback(function(window, pane, id, label)
        if not id and not label then
          wezterm.log_info("cancelled")
        else
          local _, stdout, _ = wezterm.run_child_process({
            "security",
            "find-generic-password",
            "-w",
            "-a",
            label,
            "-s",
            "wezterm-password",
          })
          pane:send_text(stdout)
        end
      end),
      title = "select account",
      choices = choices,
    }),
    pane
  )
end)

config.keys = {
  {
    key = "p",
    mods = "CTRL|SHIFT|META",
    action = act.EmitEvent("trigger-password-input"),
  },
}

config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = "Catppuccin Latte"
config.line_height = 1.2
config.font_size = 18.0
config.font = wezterm.font_with_fallback({
  { family = "UDEV Gothic NFLG" },
  { family = "UDEV Gothic NFLG", assume_emoji_presentation = true },
})

return config
