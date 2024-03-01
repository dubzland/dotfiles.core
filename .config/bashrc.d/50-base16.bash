# Base16 Shell
BASE16_SHELL_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/base16-shell"
BASE16_THEME_DEFAULT="helios"
BASE16_SHELL_HOOKS_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/tinted-theming/hooks"
[[ -n "$PS1" ]] && \
  [[ -s "$BASE16_SHELL_PATH/profile_helper.sh" ]] && \
      source "$BASE16_SHELL_PATH/profile_helper.sh"

# vim: set et ts=4 sw=4 sts=4 ft=sh:
