#
# SSH agent setup
#
if [[ -z "${SSH_AUTH_SOCK}" ]]; then
    # No agent running.  Start a new one
    eval "$(ssh-agent)"
else
    # Agent available (possibly via forwarding)
    # Check for the existence of the ssh agent symlink set via rc
    if [[ -L ${HOME}/.ssh/ssh_auth_sock ]]; then
        # Symlink exists. Is it valid?
        if [[ -e ${HOME}/.ssh/ssh_auth_sock ]]; then
            # Symlink is valid. Does it point to our instance?
            if [[ "${SSH_AUTH_SOCK}" -ef "${HOME}/.ssh/ssh_auth_sock" ]]; then
                # It does. Update environment to point to the symlink
                export SSH_AUTH_SOCK=${HOME}/.ssh/ssh_auth_sock
            fi
        else
            # Symlink is invalid (dead session)
            rm "${HOME}/.ssh/ssh_auth_sock"
        fi
    fi
fi

# vim: set et ts=4 sw=4 sts=4 ft=sh:
