# Homebrew on Linux
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
	eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# Homebrew on MacOS
if [[ -f /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# vim: set noet ts=4 sw=4 sts=4 ft=sh:
