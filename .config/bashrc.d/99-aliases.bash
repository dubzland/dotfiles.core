alias l="ls -l -h"
alias dmon="DISTCC_DIR=/var/tmp/portage/.distcc distccmon-text"
alias halt='sudo /sbin/halt'
alias reboot='sudo /sbin/reboot'
alias top='sudo top'
alias nview='nvim -R'
alias chownr='sudo find . \! -user jdubz | sudo xargs -I{} -- chown jdubz: {}'
alias tss='tmux-session switch'
alias tsn='tmux-session new'
alias tdev='tmux-session new "$(pwd)" nvim'

if which dircolors >/dev/null; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if [[ -f ~/.dir_colors ]]; then
		eval `dircolors -b ~/.dir_colors`
	elif [[ -f /etc/DIR_COLORS ]]; then
		eval `dircolors -b /etc/DIR_COLORS`
	else
		eval `dircolors -b`
	fi
	alias ls='ls --color=auto'
else
	alias ls='ls -G'
fi

# vim: set et ts=4 sw=4 sts=4 ft=sh:
