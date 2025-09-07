### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

GPG_TTY=$(tty)
export GPG_TTY

# lmao, MacOS the "good" OS...
source ~/.bashrc
. "$HOME/.cargo/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rmontalti/google-cloud-sdk/path.bash.inc' ]; then . '/Users/rmontalti/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rmontalti/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/rmontalti/google-cloud-sdk/completion.bash.inc'; fi

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/Users/rmontalti/.juliaup/bin:*)
        ;;

    *)
        export PATH=/Users/rmontalti/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@14/bin:$PATH"
