## EXPORTS ##

stty erase '^?'
#
# Man, I'm old
#
export CVS_RSH=ssh
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

if [[ "$OSTYPE" == "darwin"* ]]; then
	export PATH="/usr/local/sbin:${PATH}"
fi

if [[ ! ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
	export PATH="$HOME/.local/bin:${PATH}"
fi

if [[ $(command -v nvim) ]]; then
	export EDITOR=$(which nvim)
else
	export EDITOR=$(which vim)
fi

# vim: set et ts=4 sw=4 sts=4 ft=sh:
