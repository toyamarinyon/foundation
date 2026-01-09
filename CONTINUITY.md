## CONTINUITY.md

### Goal (incl. success criteria):
- Manage personal dotfiles in this repo (primarily zsh) and Cursor user-level hooks.
- Success:
  - Running `./setup.sh` sets up user-level symlinks for:
    - `~/.zshrc` → `foundation/zsh/.zshrc`
    - `~/.zshrc.d/` → `foundation/zsh/.zshrc.d/`
    - `~/.cursor/hooks.json` → `foundation/cursor/hooks.json`
    - `~/.cursor/hooks/` → `foundation/cursor/hooks/`
  - Zsh starts cleanly (`zsh -i -c 'echo ok'`).
  - Cursor hook runs without path mismatches (expects `.cursor/hooks/...`).

### Constraints/Assumptions:
- Repo is personal shell dotfiles, mainly zsh.
- Source of truth is `zsh/`.
- Avoid embedding absolute paths; prefer `$HOME`, `command -v`, etc.
- Zsh config is managed in a single file: `zsh/.zshrc` (no fragment system).
- Do not write outside this repository (no direct edits in the user's home dir).
- Mise handles tool versions, environments, and PATH management.

### Key decisions:
- Represent "current state" from on-repo files only; mark anything about the user's machine/symlinks as `UNCONFIRMED` unless observed in-repo.
- Treat `mise` as first-class for tool versions/env/tasks.
- Prefer `mise` for tool versions/env/tasks; keep zsh glue minimal.
- Install Cursor hooks at the user level under `~/.cursor/` by symlinking `hooks.json` and `hooks/`.

### State:
- `cursor/hooks.json` exists and references `.cursor/hooks/ensure-mise-execution.sh` (implies install path `~/.cursor/...`).
- `zsh/.zshrc` is a self-contained configuration file (mise init + basic completion/colors/prompt). `compinit` uses a cache path under `${XDG_CACHE_HOME:-${TMPDIR:-/tmp}}` to avoid writing to unwritable `$HOME`.
- `zsh/.zshrc.d/` fragment directory is not used.
- `setup.sh` will symlink Cursor hook config at user level: `~/.cursor/hooks.json` and `~/.cursor/hooks/`.

### Done:
- Created `CONTINUITY.md`.
- Updated `AGENTS.md` to assume "use mise full power".
- Removed "Never commit secrets" section from `AGENTS.md` (human-facing guidance, not agent rules).
- Created `setup.sh`: setup script that creates symlinks with backup handling for existing files.
- Updated `AGENTS.md` "Setup assumptions" section to reflect that `setup.sh` is included in the repository.
- Created `README.md`: user-facing documentation covering quick start, structure, mise tooling, and how to add configuration.
- Updated `README.md`: removed `00-secret.zsh` reference; clarified that secrets are managed via mise, not zsh fragments.
- Deleted deprecated `v1/` directory.
- Updated `README.md`: removed `v1/` reference from structure diagram.
- Added Cursor hook config under `cursor/`:
  - `cursor/hooks.json`
  - `cursor/hooks/ensure-mise-execution.sh`
- Reverted zsh fragment approach back to a single-file `zsh/.zshrc`.
- Updated `AGENTS.md` to reflect single-file zsh config (no fragments).

### Now:
- Extend `setup.sh` to install Cursor hooks at user level (`~/.cursor/hooks.json` and `~/.cursor/hooks/`).

### Next:
- Keep `CONTINUITY.md` updated at the start of each assistant turn.
- After each file edit in this repo, update `CONTINUITY.md` immediately with what changed.
- If zsh changes are made, run minimum smoke tests:
  - `zsh -i -c 'echo ok'`
  - Ensure no startup errors (esp. around `compinit`)

### Open questions (UNCONFIRMED if needed):
- Confirm Cursor reads user-level hook config from `~/.cursor/hooks.json` and resolves hook script paths relative to `$HOME` (assumed by `.cursor/hooks/...`).
- User asked why zsh config was changed; confirm whether to keep fragment-based reintroduction or revert and focus only on Cursor hooks.

### Working set (files/ids/commands):
- Files:
  - `README.md`
  - `setup.sh`
  - `AGENTS.md`
  - `CONTINUITY.md`
  - `zsh/.zshrc`
  - `cursor/hooks.json`
  - `cursor/hooks/ensure-mise-execution.sh`
