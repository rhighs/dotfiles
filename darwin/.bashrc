alias python=python3
alias pip=pip3

if command -v npm >/dev/null 2>&1; then
  export PATH="$(npm prefix -g)/bin:$PATH"
fi
# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

GPG_TTY=$(tty)
export GPG_TTY

export PATH=$PATH:$(go env GOPATH)/bin
. "$HOME/.cargo/env"
eval $(/opt/homebrew/bin/brew shellenv)
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.local/bin"
if command -v python3 >/dev/null 2>&1; then
  export PATH="$PATH:$(python3 -m site --user-base)/bin"
fi

export BASH_SILENCE_DEPRECATION_WARNING=1
export DOCKER_BUILDKIT=1

# mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# agents stuff
export PATH="$HOME/.opencode/bin:$PATH"

[ -f $HOME/.scripts/scripts-entry.sh ] && source $HOME/.scripts/scripts-entry.sh
