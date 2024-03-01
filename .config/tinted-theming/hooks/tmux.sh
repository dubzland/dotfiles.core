#!/usr/bin/env bash

if pgrep tmux >/dev/null; then
	tmux setenv -g BASE16_THEME "$BASE16_THEME"
    tmux source-file "$(tmux display-message -p "#{config_files}")"
fi
