#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

function die() {
	printf "%s\n" "$*" >&2
}

# base16-alacritty theme directory
ALACRITTY_THEME_DIR="$XDG_CONFIG_HOME/tinted-theming/base16-alacritty/colors"
[[ -d "${ALACRITTY_THEME_DIR}" ]] || die "alacrity theme directory not found"

# alacrity configuration directory
ALACRITTY_CONFIG_DIR="$XDG_CONFIG_HOME/alacritty"
[[ -d "${ALACRITTY_CONFIG_DIR}" ]] || die "alacritty config directory not found"

# Current base16 theme
[[ -n "${BASE16_THEME}" ]] || die "No base16 theme set"


# Make sure a matching theme exists
ALACRITTY_THEME_FILE="${ALACRITTY_THEME_DIR}/base16-${BASE16_THEME}-256.toml"
[[ -r "${ALACRITTY_THEME_FILE}" ]] || die "alacritty theme ${ALACRITTY_THEME_FILE} not found"

ln -sf "$ALACRITTY_THEME_FILE" "${ALACRITTY_CONFIG_DIR}/theme.toml"
