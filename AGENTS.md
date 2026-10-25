# Agents

Personal dotfiles for macOS, Linux and Windows (MSYS2).

## Layout

- `common/` shared configs: nvim, vim, tmux, alacritty theme, mise tools
- `macos/`, `linux/`, `windows/` per-OS bash, alacritty and package lists
- `install.sh` (macOS, Linux) and `install.ps1` (Windows) bootstrap a machine, both are idempotent

## Setting up a machine

```sh
git clone https://github.com/rhighs/dotfiles ~/repos/dotfiles
cd ~/repos/dotfiles
./install.sh                                           # macos, linux
powershell -ExecutionPolicy Bypass -File install.ps1   # windows
```

Then open Alacritty, it should land in tmux session `main`.

## Changing things

- CLI tools: add to `common/.config/mise/config.toml`
- Apps and system packages: `macos/Brewfile`, `linux/packages.txt`, `windows/winget.txt`, `windows/pacman.txt`
- A config that is the same everywhere belongs in `common/`, OS differences are handled inline (see `common/.tmux.conf`)
- Re-run the install script after changes and check the result in a fresh terminal

## Conventions

- One-line commit messages, `type(scope): message`, no co-author trailers
- Comments only where they help (nvim, vim), none elsewhere
- Nothing secret or machine-specific: no tokens, internal URLs, hardcoded usernames or home paths
- Prefer the macOS versions of configs when platforms disagree, they are the most up to date

## Windows notes

- No symlinks without admin: configs are linked with one-line stub files and junctions by `install.ps1`
- MSYS2 uses the Windows home (`db_home: windows` in `/etc/nsswitch.conf`), so `~` is `%USERPROFILE%`
- Alacritty passes shell args unquoted, the bash `-c` argument carries its own quotes
- mise shims need `mise.exe` on PATH, `windows/.bashrc` adds it
- Process spawns are slow under Defender, avoid forks in shell startup and the prompt
