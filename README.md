# Dotfiles

Simple dotfiles I use accross different systems, meant to be synced up using GNU stow.

## Usage

- **win32-MSYS2**: `pacman -S stow`
- **arch/fedora/debian**: `pacman -S stow`/`dnf install stow`/`apt install stow`
- **macos**: `brew install stow`

```shell
stow -d <platform-dir> -t ./$HOME .
```
