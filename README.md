# Core system configuration

Handles the bulk of the `bash` configuration (via drop-in directories), and sets
up `tmux`. Also includes configuration for [alacritty][alacritty] (primarily for
MacOS).

## Prerequisites

- tmux
- alacritty (MaxOS only)
- fzf
- ripgrep

On MacOS, install Alacritty per the [docs][alacritty-install], then install the
Alacritty terminfo:

```bash
curl -o ~/alacritty.info https://github.com/alacritty/alacritty/blob/master/extra/alacritty.info && \
sudo tic -xe alacritty,alacritty-direct ~/alacritty.info && \
rm ~/alacritty.info
```

[alacritty]: https://alacritty.org/
[alacritty-install]: https://github.com/alacritty/alacritty/blob/master/INSTALL.md#terminfo
