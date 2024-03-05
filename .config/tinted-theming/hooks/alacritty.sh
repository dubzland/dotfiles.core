#!/usr/bin/env bash

# Hook script to update alacritty colors when base16 theme switches.
# Run in a subshell to avoid mangling the parent.
(

	# Enable tracing if the DEBUG environment variable is set
	if [[ ${DEBUG} =~ ^1|yes|true$ ]]; then
		set -o xtrace
	fi

	set -o errexit
	set -o nounset
	set -o pipefail

	function die() {
		if [[ $# -eq 1 ]]; then
			printf '%s\n' "$1"
			exit 1
		fi

		if [[ ${2-} =~ ^[0-9]+$ ]]; then
			printf '%b\n' "$1"
			exit $2
		fi
	}

	XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

	# base16-alacritty theme directory
	alacritty_theme_dir="$XDG_CONFIG_HOME/tinted-theming/base16-alacritty/colors"
	[[ -d "${alacritty_theme_dir}" ]] || die "alacrity theme directory not found"

	# alacrity configuration directory
	alacritty_config_dir="$XDG_CONFIG_HOME/alacritty"
	[[ -d "${alacritty_config_dir}" ]] || die "alacritty config directory not found"

	# Current base16 theme
	[[ -n "${BASE16_THEME}" ]] || die "No base16 theme set"


	# Make sure a matching theme exists
	alacritty_theme_file="${alacritty_theme_dir}/base16-${BASE16_THEME}-256.toml"
	[[ -r "${alacritty_theme_file}" ]] || die "alacritty theme ${alacritty_theme_file} not found"

	ln -sf "$alacritty_theme_file" "${alacritty_config_dir}/theme.toml"
)
