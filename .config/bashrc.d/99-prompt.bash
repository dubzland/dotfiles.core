WORKING_DIR="${FG_YELLOW}\w${RESET_TERM}"

IDENTITY="${FG_CYAN}\u${FG_WHITE}@${FG_BLUE}\h${RESET_TERM}"

export PS1="${WORKING_DIR}\n${IDENTITY}\$(get_git_status) ${FG_WHITE}\$${RESET_TERM} "

# # vim: set et ts=4 sw=4 sts=4 ft=sh:
