#
# vi mode ftw
#
set -o vi

for file in $HOME/.config/bashrc.d/*.bash; do
	. $file
done

# vim: set et ts=4 sw=4 sts=4 ft=sh:
