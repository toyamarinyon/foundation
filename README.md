# foundation

Personal dotfiles for shell, terminal, and editor configuration.

## Quick Start

```bash
git clone https://github.com/toyamarinyon/foundation.git
cd foundation
./setup.sh
```

This sets up links in your home directory:

- `~/.zshrc` -> `foundation/zsh/.zshrc`
- `~/.zprofile` -> `foundation/zsh/.zprofile`
- `~/.config/ghostty/config.ghostty` -> `foundation/ghostty/config.ghostty`
- `~/.config/herdr/config.toml` -> `foundation/herdr/config.toml`
- `~/.config/kanae/config.json` -> `foundation/kanae/config.json`
- `~/.cursor/hooks.json` -> `foundation/cursor/hooks.json`
- `~/.cursor/hooks/` -> `foundation/cursor/hooks/`

## Structure

```text
foundation/
├── archive/
├── cursor/
│   ├── hooks.json
│   └── hooks/
├── ghostty/
│   └── config.ghostty
├── herdr/
│   └── config.toml
├── kanae/
│   └── config.json
├── setup.sh
└── zsh/
    ├── .zprofile
    └── .zshrc
```

## Local Environment

Machine-specific settings live outside this repository:

- `~/.zprofile.local` for login shell setup, such as Homebrew or OrbStack
- `~/.zshrc.local` for interactive shell setup, such as local completions

If these files exist, `zsh/.zprofile` and `zsh/.zshrc` source them after common setup. Keep secrets and machine-local paths there, not in this repository.

Examples:

```zsh
# ~/.zprofile.local
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

source "$HOME/.orbstack/shell/init.zsh" 2>/dev/null || :
```

```zsh
# ~/.zshrc.local
if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
```

## Tooling

This repo assumes [mise](https://mise.jdx.dev/) is the primary tool for:

- Dev tool versions
- Environment switching
- Task running

If mise is installed, it is activated from `zsh/.zprofile`.

## Notes

- `zsh/.zshrc` is the source of truth for shared interactive zsh configuration.
- Ghostty is managed via the XDG config path: `~/.config/ghostty/config.ghostty`.
- herdr is managed via the XDG config path: `~/.config/herdr/config.toml`.
- kanae is managed via the XDG config path: `~/.config/kanae/config.json`.
- Cursor hooks are managed at the user level under `~/.cursor/`.
- Removed setup/helper snippets from this conflict resolution are preserved in `archive/setup-and-local-config-20260603.md`.

## License

MIT
