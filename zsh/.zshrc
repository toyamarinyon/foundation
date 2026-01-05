# mise initialization
MISE_BIN="$HOME/.local/bin/mise"
if [[ -x "$MISE_BIN" ]]; then
  eval "$($MISE_BIN activate zsh)"
elif command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
else
  echo "mise is not installed. Install it from: https://mise.jdx.dev/"
fi

# Completion setup
autoload -Uz compinit
compinit

# Color support
autoload -Uz colors && colors

# PROMPT
PROMPT='
%F{239}>%f '
