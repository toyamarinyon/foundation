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
- `~/.zshrc.d/` → `foundation/zsh/.zshrc.d/`

Existing files are automatically backed up before creating symlinks.

## Structure

```
foundation/
├── setup.sh              # Symlink setup script
└── zsh/
    ├── .zshrc            # Thin loader that sources fragments
    └── .zshrc.d/         # Configuration fragments (sourced in order)
        ├── 01-env.zsh    # Environment variables
        ├── 02-path.zsh   # PATH configuration
        ├── 10-mise.zsh   # mise activation
        └── 90-prompt.zsh # Prompt and completion
```

### Fragment Ordering

Fragments in `.zshrc.d/` are sourced in alphabetical order. The naming convention:

- `01-09`: Core environment variables
- `10-89`: Tools and integrations (e.g., mise)
- `90-99`: Prompt and final setup

> **Note:** Secrets and environment variables for projects are managed via mise (`.mise.toml`), not zsh fragments.

## Tooling: mise

This configuration uses [mise](https://mise.jdx.dev/) for:

- **Dev tool versions** – replaces `asdf`, `nvm`, `pyenv`, etc.
- **Environment switching** – can replace `direnv`
- **Task running** – can replace `make` or npm scripts

If mise is installed, it's automatically activated via `10-mise.zsh`.

## Adding Configuration

1. Create a new `.zsh` file in `zsh/.zshrc.d/` with an appropriate prefix
2. The file will be automatically sourced on shell startup

Example:

```bash
# zsh/.zshrc.d/20-aliases.zsh
alias ll='ls -la'
alias gs='git status'
```

## License

MIT
