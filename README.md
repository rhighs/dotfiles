# Dotfiles

```
common/    shared everywhere: nvim, vim, tmux, alacritty/ghostty themes, mise tools
macos/     bash, alacritty, ghostty, Brewfile
linux/     bash, alacritty, ghostty, packages.txt
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

Alacritty opens a login shell on all platforms. Ghostty does the same on macOS and Linux; it does not support Windows. On macOS, use Command+T for a new native tab and Command+N for a new window. Each starts an independent shell.

Run `tmux -u new-session -A -s main` only in the tab you want attached to tmux. For a remote machine, connect with SSH first, then run that command there. SSH login does not attach automatically. Detach with Ctrl+B, then D; the session keeps running.

## Ghostty

The installer links both terminal configs through Stow; neither replaces the other.
Ghostty uses a brighter, higher-contrast version of the Alacritty palette and
follows the system light/dark appearance (`theme = light:dotfiles-light,dark:dotfiles`).
Both use the same login shell and platform-specific font settings:
JetBrainsMono Nerd Font at 12pt on macOS, Source Code Pro at 8pt on Linux.
macOS installs Ghostty and the Nerd Font through the Brewfile. On Linux, install
Ghostty using [its distribution instructions](https://ghostty.org/docs/install/binary)
and install Source Code Pro with your package manager.

On macOS, `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`
loads after the XDG config and can override it. Keep personal overrides there,
or back it up to use only these dotfiles.
