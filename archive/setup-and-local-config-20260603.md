# Setup/local config backup (2026-06-03)

This file preserves setup and machine-local shell snippets that were removed
while resolving the `git pull` conflict.

## Previous setup behavior

The old `setup.sh` had a reusable `create_symlink` helper that:

- checked whether a destination already existed,
- compared an existing symlink target,
- moved existing files to `*.backup.YYYYMMDD_HHMMSS`,
- created parent directories,
- then created symlinks.

It linked:

- `$HOME/.zshrc` -> `zsh/.zshrc`
- `$HOME/.zprofile` -> `zsh/.zprofile`
- `$HOME/.config/ghostty/config.ghostty` -> `ghostty/config.ghostty`
- `$HOME/.cursor/hooks.json` -> `cursor/hooks.json`
- `$HOME/.cursor/hooks` -> `cursor/hooks`

## Machine-local shell snippets

These snippets were removed from repo-managed zsh files because they contain
machine-specific paths or app integrations. Put them in `$HOME/.zprofile.local`
or `$HOME/.zshrc.local` if they are still needed.

```zsh
# Homebrew shellenv
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

# OrbStack
source "$HOME/.orbstack/shell/init.zsh" 2>/dev/null || :

# Google Cloud SDK
if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
```
