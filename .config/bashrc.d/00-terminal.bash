# Terminal colors
BG_BLACK="\[\033[40m\]"
BG_RED="\[\033[41m\]"
BG_GREEN="\[\033[42m\]"
BG_YELLOW="\[\033[43m\]"
BG_BLUE="\[\033[44m\]"
BG_MAGENTA="\[\033[45m\]"
BG_CYAN="\[\033[46m\]"
BG_WHITE="\[\033[47m\]"
FG_BLACK="\[\033[30m\]"
FG_RED="\[\033[31m\]"
FG_GREEN="\[\033[32m\]"
FG_YELLOW="\[\033[33m\]"
FG_BLUE="\[\033[34m\]"
FG_MAGENTA="\[\033[35m\]"
FG_CYAN="\[\033[36m\]"
FG_WHITE="\[\033[37m\]"
RESET_TERM="\[\033[0m\]"

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
export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo

# Change the window title of X terminals
case $TERM in
	xterm*|rxvt*|Eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

# Base16 Shell
BASE16_THEME_DEFAULT="helios"
BASE16_SHELL_PATH="$HOME/.local/share/base16-shell"
[[ -n "$PS1" ]] && \
  [[ -s "$BASE16_SHELL_PATH/profile_helper.sh" ]] && \
      source "$BASE16_SHELL_PATH/profile_helper.sh"

# vim: set et ts=4 sw=4 sts=4 ft=sh:
