# .bash_profile

for file in $HOME/.config/bash_profile.d/*.bash; do
	. $file
done

[[ -f ~/.bashrc ]] && . ~/.bashrc

# vim: set et ts=4 sw=4 sts=4 ft=sh:
