# TMUX DISPLAY setting
if [ -n "$DISPLAY" ]; then
	if [ $(command -v tmux) ]; then
		for name in `tmux ls -F '#{session_name}' 2>/dev/null`; do
			tmux setenv -t $name DISPLAY $DISPLAY
			tmux setenv -g -t $name DISPLAY $DISPLAY
		done
	fi
fi

# vim: set et ts=4 sw=4 sts=4 ft=sh:
