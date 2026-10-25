# msys2 port of darwin/.bashrc: keep forks out of startup and the prompt, every
# process spawn costs ~50ms on windows

# windows home as a posix path (msys2 HOME is /home/<user>)
WINHOME=${USERPROFILE//\\//}
d=${WINHOME:0:1}; WINHOME="/${d,,}${WINHOME:2}"; unset d

# clean up inherited windows PATH: drop dupes, missing dirs, and git-for-windows
# bins (they ship a second msys runtime that clashes with msys2's)
clean_path() {
    local IFS=: out= p
    for p in $PATH; do
        case "$p" in
            ""|*"/Git/usr/bin"|*"/Git/mingw64/bin") continue ;;
        esac
        case ":${out,,}:" in *":${p,,}:"*) continue ;; esac
        [ -d "$p" ] && out="${out:+$out:}$p"
    done
    PATH=$out
}

export PNPM_HOME="$WINHOME/AppData/Local/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$PATH:$WINHOME/AppData/Roaming/npm:$WINHOME/go/bin:$WINHOME/.cargo/bin:$WINHOME/.local/bin"
export PATH="$PATH:$WINHOME/AppData/Local/Microsoft/WinGet/Links:/c/Program Files/Neovim/bin:/c/Program Files/Alacritty"
export PATH="$HOME/.opencode/bin:$PATH"
clean_path; unset -f clean_path

GPG_TTY=$(tty)
export GPG_TTY

export DOCKER_BUILDKIT=1

# mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

# fzf key bindings and fuzzy completion, cached (delete the file after upgrading fzf)
if command -v fzf >/dev/null 2>&1; then
  [ -s ~/.cache/fzf.bash ] || { mkdir -p ~/.cache && fzf --bash > ~/.cache/fzf.bash; }
  . ~/.cache/fzf.bash
fi

# reads .git/HEAD directly and runs from PROMPT_COMMAND: $(...) in PS1 forks a subshell
git_branch() {
    local head
    GIT_BRANCH=
    [ -f .git/HEAD ] && read -r head < .git/HEAD || return
    case "$head" in
        "ref: refs/heads/"*) GIT_BRANCH=" [${head#ref: refs/heads/}]" ;;
        *) GIT_BRANCH=" [HEAD]" ;;
    esac
}
PROMPT_COMMAND="git_branch${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# update ps1 to include the git branch
PS1='\u:\W${GIT_BRANCH} $ '

[ -f $HOME/.scripts/scripts-entry.sh ] && source $HOME/.scripts/scripts-entry.sh

# designkit: claude with the panel doorbell channel loaded (see README, Session panel)
alias dk='DESIGNKIT_CHANNEL=1 claude --dangerously-load-development-channels server:designkit'
