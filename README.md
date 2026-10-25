# Dotfiles

Simple dotfiles I use accross different systems, one dir per platform (`darwin`, `linux`, `win32`).

## Usage

Clone and run the bootstrap, it installs packages and links configs. Safe to re-run.

- **darwin/linux**: `./install.sh`
  - darwin: homebrew + `darwin/Brewfile`, then `stow` into `$HOME`
  - linux: pacman/apt/dnf with `linux/packages.txt`, mise via mise.run, then `stow`
- **win32**: `powershell -ExecutionPolicy Bypass -File install.ps1`
  - winget apps from `win32/winget.txt`, MesloLGS NF font, msys2 update + `win32/pacman.txt`
  - links via one-line stubs / an nvim junction (no symlinks without admin)

Add a tool by adding a line to the platform's package list.

## Windows notes

- msys2 `HOME` is `C:\msys64\home\<user>`, that's where the `.bashrc`/`.tmux.conf` stubs go.
- process spawns are slow under Defender, an elevated
  `Add-MpPreference -ExclusionPath C:\msys64` helps a lot.
