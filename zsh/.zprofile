# mise shims for login/non-interactive shells
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh --shims)"
elif [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate zsh --shims)"
fi

if [[ -r "$HOME/.zprofile.local" ]]; then
  source "$HOME/.zprofile.local"
fi
