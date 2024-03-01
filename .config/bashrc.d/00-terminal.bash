# Terminal colors
export BG_BLACK="\[\033[40m\]"
export BG_RED="\[\033[41m\]"
export BG_GREEN="\[\033[42m\]"
export BG_YELLOW="\[\033[43m\]"
export BG_BLUE="\[\033[44m\]"
export BG_MAGENTA="\[\033[45m\]"
export BG_CYAN="\[\033[46m\]"
export BG_WHITE="\[\033[47m\]"
export FG_BLACK="\[\033[30m\]"
export FG_RED="\[\033[31m\]"
export FG_GREEN="\[\033[32m\]"
export FG_YELLOW="\[\033[33m\]"
export FG_BLUE="\[\033[34m\]"
export FG_MAGENTA="\[\033[35m\]"
export FG_CYAN="\[\033[36m\]"
export FG_WHITE="\[\033[37m\]"
export RESET_TERM="\[\033[0m\]"

# Terminal capabilities
local256="$COLORTERM$XTERM_VERSION$ROXTERM_ID$KONSOLE_DBUS_SESSION"
if [[ -n "$local256" ]]; then
	case "$TERM" in
		'xfce4-terminal') TERM=xterm-256color;;
		'screen') TERM=screen-256color;;
		'Eterm') TERM=Eterm-256color;;
	esac

	export TERM
fi
unset local256

# Terminfo overrides
export TERMINFO_DIRS=$TERMINFO_DIRS:"${XDG_DATA_HOME:-$HOME/.local/share}/terminfo"

# Change the window title of X terminals
case $TERM in
	xterm*|rxvt*|Eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

# vim: set et ts=4 sw=4 sts=4 ft=sh:
