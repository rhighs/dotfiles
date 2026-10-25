alias python=python3
alias pip=pip3

if command -v npm >/dev/null 2>&1; then
  export PATH="$(npm prefix -g)/bin:$PATH"
fi

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

GPG_TTY=$(tty)
export GPG_TTY

command -v go >/dev/null 2>&1 && export PATH=$PATH:$(go env GOPATH)/bin
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
eval $(/opt/homebrew/bin/brew shellenv)
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.local/bin"
if command -v python3 >/dev/null 2>&1; then
  export PATH="$PATH:$(python3 -m site --user-base)/bin"
fi

export BASH_SILENCE_DEPRECATION_WARNING=1
export DOCKER_BUILDKIT=1

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

command -v fzf >/dev/null 2>&1 && eval "$(fzf --bash)"

export PATH="$HOME/.opencode/bin:$PATH"

git_branch() {
    if [ -e .git ]; then
        local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [ $? -eq 0  ]; then
            echo " [$branch]"
        fi
    fi
}

PS1='\u:\W$(git_branch) $ '

[ -f $HOME/.scripts/scripts-entry.sh ] && source $HOME/.scripts/scripts-entry.sh

alias dk='DESIGNKIT_CHANNEL=1 claude --dangerously-load-development-channels server:designkit'

export SUPERWIKI_WORKSPACE="$HOME/repos/superwiki"

pnpm() {
  if [ "$1" = "dev" ]; then
    NODE_OPTIONS="--max-old-space-size=1536 ${NODE_OPTIONS}" command pnpm "$@"
  else
    command pnpm "$@"
  fi
}
