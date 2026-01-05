## CONTINUITY.md

### Goal (incl. success criteria):
- Create setup script that creates symlink: `~/.zshrc` → `foundation/zsh/.zshrc`
- Success: repository clone → script execution → symlink is set up automatically
- Maintain a compaction-safe session briefing for this repo.
- Keep repo guidance aligned with the user's "use mise full power" direction (tool versions/env/tasks).
- Simplify zsh configuration to a single `.zshrc` file that relies on mise for tool management.

### Constraints/Assumptions:
- Repo is personal shell dotfiles, mainly zsh.
- Source of truth is `zsh/`.
- Avoid embedding absolute paths; prefer `$HOME`, `command -v`, etc.
- Zsh config is consolidated into a single `zsh/.zshrc` file (no fragment system).
- Do not write outside this repository (no direct edits in the user's home dir).
- Mise handles tool versions, environments, and PATH management.

### Key decisions:
- Represent "current state" from on-repo files only; mark anything about the user's machine/symlinks as `UNCONFIRMED` unless observed in-repo.
- Treat `mise` as first-class for tool versions/env/tasks.
- Removed fragment-based `.zshrc.d` system in favor of single-file configuration.
- Removed PATH management (mise handles it).

### State:
- `zsh/.zshrc` is a self-contained configuration file that:
  - Detects mise installation (`$HOME/.local/bin/mise` or `command -v mise`)
  - Initializes mise if found, or displays installation link if not
  - Sets up completion (`compinit`) and colors
  - Configures PROMPT (minimal prompt: `%F{239}>%f `)
- Fragment system (`zsh/.zshrc.d/`) has been removed.

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
- Simplified zsh configuration: consolidated into single `zsh/.zshrc` file.
- Removed fragment system: deleted `zsh/.zshrc.d/` directory and all fragment files.
- Updated `zsh/.zshrc` to include mise detection, initialization, completion, colors, and PROMPT directly.
- Updated `setup.sh` to remove `.zshrc.d` symlink creation and checks (now only creates `~/.zshrc` symlink).

### Now:
- `zsh/.zshrc` is a self-contained configuration file with mise initialization and basic zsh setup.
- Fragment system has been removed; all configuration is in `.zshrc`.
- `setup.sh` creates symlink: `~/.zshrc` → `foundation/zsh/.zshrc` (no longer needs `.zshrc.d` symlink).

### Next:
- Keep `CONTINUITY.md` updated at the start of each assistant turn.
- After each file edit in this repo, update `CONTINUITY.md` immediately with what changed.
- If zsh changes are made, run minimum smoke tests:
  - `zsh -i -c 'echo ok'`
  - Ensure no startup errors (esp. around `compinit`)

### Open questions (UNCONFIRMED if needed):
- None.

### Working set (files/ids/commands):
- Files:
  - `README.md`
  - `setup.sh`
  - `AGENTS.md`
  - `CONTINUITY.md`
  - `zsh/.zshrc`
