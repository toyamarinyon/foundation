# mise (optional)
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
elif [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

# Completion setup
autoload -Uz compinit
compinit -i

source <(jj util completion zsh)

# Color support
autoload -Uz colors && colors

# PROMPT
PROMPT='
%F{239}>%f '
