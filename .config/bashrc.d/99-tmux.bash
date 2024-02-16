# TMUX DISPLAY setting
if [ -n "$DISPLAY" ]; then
	if [ $(command -v tmux) ]; then
		for name in `tmux ls -F '#{session_name}' 2>/dev/null`; do
			tmux setenv -t $name DISPLAY $DISPLAY
			tmux setenv -g -t $name DISPLAY $DISPLAY
		done
	fi
fi

# Sets up a tmux session based on the current directory
function tdev {
	name=$1
	if [[ -z $1 ]]; then
		name=${PWD##*/}
	fi
	name=$(echo "$name" | sed "s/\./_/g")
	tmux new -s "$name" -n code -d
	tmux split-window -t "$name":0.0 -v -p 20
	tmux split-window -t "$name":0.1 -h -p 50
	tmux send-keys -t "$name":0.0 "nvim" C-m
	tmux select-pane -t "$name":0.0
	TMUX= tmux attach-session -t "$name"
	sleep 1
}

# vim: set et ts=4 sw=4 sts=4 ft=sh:
