alias python=python3
alias pip=pip3

eval $(/opt/homebrew/bin/brew shellenv)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

xmlformat-inplace ()
{
    xmllint --format "$1" > "$1".formatted && mv "$1".formatted "$1"
}

xmlformat ()
{
    for i in "$@"; do
    case $i in
        -r=*|--recursive=*)
        RECURSIVE=1
        ;;
        -i=*|--nocase=*)
        NOCASE=1
        ;;
        *)
        PATTERN=$i # default option
        ;;
    esac;
    done;

    if [ -z $PATTERN ]; then
        return 1 ;
    fi

    if $RECURSIVE && $NOCASE ; then
        PATTERN="";
        find . -iname "$PATTERN" -type f -exec xmlformat-inplace _ {} + ;
    elif $RECURSIVE ; then
        find . -name "$PATTERN" -type f -exec xmlformat-inplace _ {} + ;
    else
        xmlformat-inplace _ $PATTERN
    fi
}

todo ()
{
    vim ~/.local/.todo-items
}

colima-start ()
{
    # this --vm-arg was really just for an insufficient memory error given by an elastic search container
    # on a sonarqube docker compose file...
    # other params are setting: 4 cores, 8GB mem for colima to be used
    #
    # provision:
    #   - mode: system
    #   script: sysctl -w vm.max_map_count=262144
    #
    # make sure to set this value in `colima template`
    colima start --cpu 4 --memory 8 --vm-type=vz;
}

postgres-start ()
{
    docker run --name postgres-temp -d -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres:12;
}

postgres-stop ()
{
    docker stop postgres-temp && docker rm postgres-temp;
}

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

replacetabs ()
{
    find $1 -iname "*.${2}" -type f -exec sed -i.orig 's/\t/    /g' {} +
}

webm2mp3 ()
{
    for FILE in *.webm; do
        echo -e "Processing video '\e[32m$FILE\e[0m'";
        ffmpeg -i "${FILE}" -vn -ab 128k -ar 44100 -y "${FILE%.webm}.mp3";
    done;
}

git-del-missing-branches () {
    local remote="${1:-origin}"
    git fetch --prune "$remote";
    DBRANCHES=$(for branch in $(git for-each-ref --format='%(refname:short)' refs/heads/*); do
        if ! git ls-remote --exit-code --heads "$remote" "$branch" > /dev/null; then
            echo "$branch"
        fi
    done)
    if [ -n "$DBRANCHES" ]; then
        echo -e "Found missing branches:\n\n$DBRANCHES\n"
        read -p "Are you sure to want to delete them? (Y/n): " confirm
        confirm=${confirm:-Y}
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            echo "$DBRANCHES" | xargs -r git branch -D
        fi
    fi
}

#android stuff
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export JAVA_HOME=$(/usr/libexec/java_home)

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# custom binaries
export PATH="$PATH:$HOME/.local/bin"

# common scripts entry sh
[ -f $HOME/.scripts/scripts-entry.sh ] && source $HOME/.scripts/scripts-entry.sh

[ -f "/Users/rmontalti/.ghcup/env" ] && source "/Users/rmontalti/.ghcup/env" # ghcup-env

. "$HOME/.cargo/env"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}"  ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# pnpm
export PNPM_HOME="/Users/rmontalti/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH=$PATH:$(npm config get prefix)/bin
export PATH=$PATH:$(go env GOPATH)/bin
