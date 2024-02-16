# Recursively calculate the size of the current directory, without crossing
# filesystem boundaries.  Results are sorted ascending.
function cds {
	du=""
	sort=""
	case "$OSTYPE" in
		darwin*)
			du="gdu"
			sort="gsort"
			;;
		linux*)
			du="du"
			sort="sort"
			;;
		*)
			echo "wut"
			;;
	esac
	if [[ -n "${du}" ]] && [[ -n "${sort}" ]]; then
		exec ${du} -ckshx .[!.]* * 2>/dev/null | ${sort} -h
	fi
}

function dcr {
	docker-compose run --rm $@
}

function dcu {
	docker-compose up $@
}

function dcub {
	docker-compose up -d $@
}

function gp {
	grep -rn --color=always $@ | less -R
}

function parse_git_dirty {
	[[ $(git status --porcelain 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)] /"
}

function get_git_status {
	branch=$(git symbolic-ref HEAD --short 2> /dev/null)
	if [[ -z $branch ]]; then
		echo ""
	else
		green="\x01\x1b[32m\x02"
		yellow="\x01\x1b[33m\x02"
		pre=""
		post=""
		if [[ $(git status --porcelain 2> /dev/null | tail -n1) != "" ]]; then
			pre="$yellow"
			post="*"
		else
			pre="$green"
		fi
		echo -e " \001\033[37m\002[\001\033[0m\003$pre$branch$post\001\033[37m\002]\001\033[0m\002"
	fi
}

function reexport_ps1 {
	export PS1="\[\033[37m\]\w\n\[\033[31m\]\u@\h $(get_git_status2)\[\033[0m\]-> \[\033[0m\]"
}

function reexport_ps1_default {
	export PS1="\[\033[37m\]\w\n\[\033[31m\]\u@\h \$(get_git_status)\[\033[0m\]-> \[\033[0m\]"
}

function abspath {
	dir=$1
	if [[ -d "$dir" ]]; then
		(cd "$dir"; pwd)
	elif [[ -f "$dir" ]]; then
		filename=$(basename $dir)
		dir=$(abspath $(dirname $dir))
		if [[ $? -eq 0 ]]; then
			echo "$dir/$filename"
		else
			exit 1
		fi
	else
		echo "File not found: $dir"
		exit 1
	fi
}

# vim: set et ts=4 sw=4 sts=4 ft=sh:
