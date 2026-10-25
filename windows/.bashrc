WINHOME=${USERPROFILE//\\//}
d=${WINHOME:0:1}; WINHOME="/${d,,}${WINHOME:2}"; unset d

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
export PATH="$HOME/.opencode/bin:$PNPM_HOME:$PATH"
export PATH="$PATH:$WINHOME/AppData/Roaming/npm:$WINHOME/go/bin:$WINHOME/.cargo/bin:$WINHOME/.local/bin"
export PATH="$PATH:/c/Program Files/Alacritty:$WINHOME/AppData/Local/mise/shims"
clean_path; unset -f clean_path

export GPG_TTY=$(tty)
export DOCKER_BUILDKIT=1

if command -v fzf >/dev/null 2>&1; then
    [ -s ~/.cache/fzf.bash ] || { mkdir -p ~/.cache && fzf --bash > ~/.cache/fzf.bash; }
    . ~/.cache/fzf.bash
fi

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
PS1='\u:\W${GIT_BRANCH} $ '

[ -f $HOME/.scripts/scripts-entry.sh ] && source $HOME/.scripts/scripts-entry.sh

alias dk='DESIGNKIT_CHANNEL=1 claude --dangerously-load-development-channels server:designkit'
