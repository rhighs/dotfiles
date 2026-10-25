#!/usr/bin/env bash
# bootstrap: install packages and link configs for the current platform.
# windows: run install.ps1 instead (installs winget apps + msys2, then calls this from msys2)
set -euo pipefail
cd "$(dirname "$0")"
DOT=$PWD

case "$(uname -s)" in
    Darwin) PLAT=darwin ;;
    Linux) PLAT=linux ;;
    MINGW*|MSYS*|CYGWIN*) PLAT=win32 ;;
    *) echo "unsupported platform: $(uname -s)" >&2; exit 1 ;;
esac

pkgs() { grep -v '^\s*#' "$1" | xargs; }

# replace a config file with a one-line pointer into the repo (no symlinks on windows without admin)
stub() {
    local file=$1 content=$2
    [ -f "$file" ] && [ "$(cat "$file")" = "$content" ] && return
    if [ -e "$file" ] && ! grep -qF "/win32/" "$file"; then
        mv "$file" "$file.bak.$(date +%s)"
    fi
    mkdir -p "$(dirname "$file")"
    printf '%s\n' "$content" > "$file"
    echo "linked $file"
}

junction() {
    local link=$1 target=$2
    [ "$(readlink -f "$link" 2>/dev/null)" = "$(readlink -f "$target")" ] && return
    [ -e "$link" ] && mv "$link" "$link.bak.$(date +%s)"
    cmd //c mklink /J "$(cygpath -w "$link")" "$(cygpath -w "$target")" >/dev/null
    echo "linked $link"
}

case $PLAT in
    darwin)
        if ! command -v brew >/dev/null; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        eval "$(/opt/homebrew/bin/brew shellenv)"
        brew bundle --file darwin/Brewfile
        stow --restow --ignore='Brewfile' -d darwin -t "$HOME" .
        ;;
    linux)
        if command -v pacman >/dev/null; then sudo pacman -S --needed --noconfirm $(pkgs linux/packages.txt)
        elif command -v apt-get >/dev/null; then sudo apt-get update && sudo apt-get install -y $(pkgs linux/packages.txt)
        elif command -v dnf >/dev/null; then sudo dnf install -y $(pkgs linux/packages.txt)
        else echo "no supported package manager" >&2; exit 1
        fi
        command -v mise >/dev/null || curl -fsSL https://mise.run | sh
        stow --restow --ignore='packages\.txt' -d linux -t "$HOME" .
        ;;
    win32)
        pacman -S --needed --noconfirm $(pkgs win32/pacman.txt)
        stub "$(cygpath -u "$APPDATA")/alacritty/alacritty.toml" \
            "$(printf '[general]\nimport = ["%s/win32/alacritty/alacritty.toml"]' "$(cygpath -m "$DOT")")"
        stub "$HOME/.tmux.conf" "source-file \"$DOT/win32/.tmux.conf\""
        stub "$HOME/.bashrc" ". \"$DOT/win32/.bashrc\""
        junction "$(cygpath -u "$LOCALAPPDATA")/nvim" "$DOT/win32/nvim"
        ;;
esac

echo "done ($PLAT)"
