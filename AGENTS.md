## AGENTS.md

This repository contains **personal shell dotfiles (mainly zsh)**.

- **Current source of truth**: `zsh/`

## Important rules

- **Do not embed absolute paths**
  - Avoid user-specific paths (e.g. `/Users/...`). Prefer `command -v`, `$HOME`, or other environment-based resolution.
- **Keep zsh config single-file**
  - `zsh/.zshrc` is the source of truth.
  - Prefer editing `zsh/.zshrc` directly (no fragment system).
- **Use mise “full power” as the default**
  - Assume `mise` is the standard tool for:
    - dev tool versions (replacing `asdf`, `nvm`, `pyenv`, etc.)
    - environment switching (can replace `direnv`)
    - task running (can replace `make` / npm scripts)
  - If adding new language/tool setup, prefer wiring it through `mise` first, and keep zsh glue minimal (e.g., enable hooks if installed).

## Setup assumptions

A setup script `setup.sh` is included in this repository. After cloning the repository, run:

```bash
./setup.sh
```

This script will:

- Symlink `~/.zshrc` → `foundation/zsh/.zshrc`
- Back up any existing files before creating symlinks
- Skip creation if symlinks already point to the correct location

## What agents should / should not do

- **Do**
  - Improve `zsh/.zshrc` (portability, readability, safety)
- **Do not**
  - Write directly into the user's home directory (i.e., do not change files outside this repository)
