''
  function tmuxpopup() {
    local width='80%'
    local height='80%'
    local session="$(tmux display-message -p -F '#{session_name}')"
    if test "''${session#*popup}" != "$session"; then # $session contains "popup"
      tmux detach-client
    else
      tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E "tmux new -A -s popup"
    fi
  }
''
