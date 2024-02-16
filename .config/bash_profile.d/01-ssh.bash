#
# SSH agent setup
#
if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval $(ssh-agent)
else
    if [[ -h $HOME/.ssh/ssh_auth_sock ]]; then
        if [[ "$SSH_AUTH_SOCK" -ef "$HOME/.ssh/ssh_auth_sock" ]]; then
            export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
        fi
    fi
fi

# vim: set et ts=4 sw=4 sts=4 ft=sh:
