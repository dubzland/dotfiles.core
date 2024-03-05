#!/usr/bin/env bash

# Hook script to update tmux sessions when base16 theme switches.

if pgrep tmux >/dev/null; then
	tmux setenv -g BASE16_THEME "$BASE16_THEME"
    tmux source-file "$(tmux display-message -p "#{config_files}")"
fi
