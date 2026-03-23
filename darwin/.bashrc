alias python=python3
alias pip=pip3

export PATH="$(npm prefix -g)/bin:$PATH"
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
export PATH="$PATH:$(python -m site --user-base)/bin"

export BASH_SILENCE_DEPRECATION_WARNING=1
export DOCKER_BUILDKIT=1

# mise
eval "$(~/.local/bin/mise activate bash)"

# agents stuff
export PATH="$HOME/.opencode/bin:$PATH"

[ -f $HOME/.scripts/scripts-entry.sh ] && source $HOME/.scripts/scripts-entry.sh
