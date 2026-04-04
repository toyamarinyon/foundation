# Completion setup
autoload -Uz compinit
compinit -i
source <(jj util completion zsh)

# Color support
autoload -Uz colors && colors

# PROMPT
PROMPT='
%F{239}>%f '
