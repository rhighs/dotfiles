# UTF-8 locale for this shell and every TUI it starts.
#
# SSH only forwards the client's locale when the server accepts it, and the
# forwarded name is not always installed on the other machine. In a non-UTF-8
# locale ncurses and other TUI toolkits draw every non-ASCII character as "_",
# so pick the first UTF-8 locale this machine actually has.
#
# Sourced from .bashrc, must stay free of side effects beyond the locale.

if [ -n "${SSH_CONNECTION:-}" ]; then
    case "$(locale charmap 2>/dev/null)" in
        UTF-8|utf8) return 0 ;;
    esac
else
    case "${LC_ALL:-${LC_CTYPE:-${LANG:-}}}" in
        *[Uu][Tt][Ff]-8*|*[Uu][Tt][Ff]8*) return 0 ;;
    esac
fi

unset LC_ALL LANG LC_CTYPE
for loc in en_US.UTF-8 C.UTF-8 en_GB.UTF-8; do
    case "$(LANG=$loc LC_CTYPE=$loc locale charmap 2>/dev/null)" in
        UTF-8|utf8) export LANG=$loc LC_CTYPE=$loc; break ;;
    esac
done
