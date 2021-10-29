function fish_user_key_bindings
    bind -M insert \cx '__fzf_ghq'
    bind -M insert \cr '__fzf_history'
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
end
