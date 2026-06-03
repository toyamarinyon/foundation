# foundation

Personal shell dotfiles for zsh.

## Quick Start

```bash
git clone https://github.com/toyamarinyon/foundation.git
cd foundation
./setup.sh
```

This will create symlinks in your home directory:

- `~/.zshrc` → `foundation/zsh/.zshrc`
- `~/.zprofile` → `foundation/zsh/.zprofile`

Existing files are automatically backed up before creating symlinks.

## Structure

```
foundation/
├── setup.sh              # Symlink setup script
└── zsh/
    ├── .zprofile         # Login shell setup
    └── .zshrc            # Interactive shell setup
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

## Tooling: mise

This configuration uses [mise](https://mise.jdx.dev/) for:

- **Dev tool versions** – replaces `asdf`, `nvm`, `pyenv`, etc.
- **Environment switching** – can replace `direnv`
- **Task running** – can replace `make` or npm scripts

If mise is installed, it's automatically activated from `zsh/.zprofile`.

## Adding Configuration

Edit `zsh/.zshrc` for shared interactive shell configuration. For machine-specific setup, use `~/.zprofile.local` or `~/.zshrc.local`.

## License

MIT
