# Dotfiles

```
common/    shared everywhere: nvim, vim, tmux, alacritty theme, mise tools
macos/     bash, alacritty, Brewfile
linux/     bash, alacritty, packages.txt
windows/   bash (msys2), alacritty, winget.txt, pacman.txt
```

## Setup

```sh
./install.sh                                           # macos, linux
powershell -ExecutionPolicy Bypass -File install.ps1   # windows
```

Installs packages, links configs into place and runs `mise install`. Safe to re-run.

- CLI tools go in `common/.config/mise/config.toml`
- Apps and system packages go in the platform's package list

## Windows

- Configs are linked with one-line stubs and junctions, symlinks need admin
- msys2 and cygwin use the Windows home (`db_home: windows`)
- Defender slows every process spawn, from an elevated shell: `Add-MpPreference -ExclusionPath C:\msys64`

## Terminal sessions

Alacritty opens a login shell on all platforms. On macOS, use Command+T for a new native tab and Command+N for a new window. Each starts an independent shell.

Run `tmux -u new-session -A -s main` only in the tab you want attached to tmux. For a remote machine, connect with SSH first, then run that command there. SSH login does not attach automatically. Detach with Ctrl+B, then D; the session keeps running.
