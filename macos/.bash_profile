if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/.resend/bin:$PATH"
