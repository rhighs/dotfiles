#!/usr/bin/env bash
set -euo pipefail
dir="$HOME/Library/LaunchAgents"
mkdir -p "$dir" "$HOME/Library/Logs"
uid=$(id -u)
tmux_bin=/opt/homebrew/bin/tmux

write() {
    local label=$1 body=$2 p="$dir/$1.plist"
    cat > "$p.new" <<PL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>$label</string>
  <key>EnvironmentVariables</key>
  <dict>
    <key>LANG</key><string>en_US.UTF-8</string>
    <key>LC_CTYPE</key><string>en_US.UTF-8</string>
    <key>PATH</key><string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string></dict>
$body
</dict>
</plist>
PL
    if ! cmp -s "$p.new" "$p"; then
        mv "$p.new" "$p"
        launchctl bootout "gui/$uid/$label" 2>/dev/null || true
        launchctl bootstrap "gui/$uid" "$p"
    else
        rm "$p.new"
        launchctl print "gui/$uid/$label" >/dev/null 2>&1 || launchctl bootstrap "gui/$uid" "$p"
    fi
}

write dev.rhighs.tmux "  <key>ProgramArguments</key>
  <array><string>/bin/sh</string><string>-c</string><string>$tmux_bin has-session -t main 2>/dev/null || exec $tmux_bin -u new-session -d -s main</string></array>
  <key>RunAtLoad</key><true/>
  <key>AbandonProcessGroup</key><true/>"

write dev.rhighs.tmux-autosave "  <key>ProgramArguments</key>
  <array><string>$HOME/.local/bin/tmux-autosave</string></array>
  <key>StartInterval</key><integer>300</integer>
  <key>RunAtLoad</key><false/>"
