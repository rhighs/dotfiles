#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

pkgs() { grep -v '^#' "$1" | xargs; }

case "$(uname -s)" in
    Darwin)
        command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
        brew bundle --file macos/Brewfile
        os=macos
        ;;
    Linux)
        if command -v pacman >/dev/null; then sudo pacman -S --needed --noconfirm $(pkgs linux/packages.txt)
        elif command -v apt-get >/dev/null; then sudo apt-get update && sudo apt-get install -y $(pkgs linux/packages.txt)
        elif command -v dnf >/dev/null; then sudo dnf install -y $(pkgs linux/packages.txt)
        fi
        command -v mise >/dev/null || curl -fsSL https://mise.run | sh
        export PATH="$HOME/.local/bin:$PATH"
        os=linux
        ;;
    *)
        echo "on windows run install.ps1" >&2
        exit 1
        ;;
esac

repo=$(basename "$PWD")
for link in "$HOME"/.[!.]* "$HOME"/.config/*; do
    if [ -L "$link" ] && [ ! -e "$link" ] && [[ $(readlink "$link") == *"$repo/"* ]]; then
        rm "$link"
    fi
done

stow --restow --ignore='Brewfile|packages\.txt' -t "$HOME" common "$os"
mise install
