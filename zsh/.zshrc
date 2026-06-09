# Completion setup
autoload -Uz compinit
compinit -i
if command -v jj >/dev/null 2>&1; then
  source <(jj util completion zsh)
fi

# Color support
autoload -Uz colors && colors

# PROMPT
PROMPT='
%F{239}>%f '

if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
elif [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
fi
