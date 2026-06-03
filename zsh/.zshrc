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
