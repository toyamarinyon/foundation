## CONTINUITY.md

### Goal (incl. success criteria):
- Create setup script that creates symlinks: `~/.zshrc` → `foundation/zsh/.zshrc` and `~/.zshrc.d/` → `foundation/zsh/.zshrc.d/`
- Success: repository clone → script execution → symlinks are set up automatically
- Maintain a compaction-safe session briefing for this repo.
- Keep repo guidance aligned with the user's "use mise full power" direction (tool versions/env/tasks).

### Constraints/Assumptions:
- Repo is personal shell dotfiles, mainly zsh.
- Source of truth is `zsh/`.
- Avoid embedding absolute paths; prefer `$HOME`, `command -v`, etc.
- Zsh config is split into fragments under `zsh/.zshrc.d/` and sourced in order by `zsh/.zshrc`.
- Do not write outside this repository (no direct edits in the user's home dir).

### Key decisions:
- Represent "current state" from on-repo files only; mark anything about the user's machine/symlinks as `UNCONFIRMED` unless observed in-repo.
- Treat `mise` as first-class for tool versions/env/tasks.

### State:
- `zsh/.zshrc` is a thin loader that sources `$HOME/.zshrc.d/*.zsh`.
- `zsh/.zshrc.d/00-secret.zsh.example` exists in-repo (legacy template), but the current direction is to manage secrets via `mise` (redaction + CI masking) instead of zsh secret fragments.
- `zsh/.zshrc.d/01-env.zsh` sets `GOPATH` and `ULTRAHOPE_LLM_API_KEY` (derived from `MINIMAX_CP_KEY`).
- `zsh/.zshrc.d/02-path.zsh` defines `addpath` and prepends several `$HOME`-based paths (incl. `$GOPATH/bin`).
- `zsh/.zshrc.d/10-mise.zsh` enables `mise` if installed.
- `zsh/.zshrc.d/90-prompt.zsh` runs `compinit`, loads `colors`, and sets `PROMPT`.

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

### Now:
- `setup.sh` created and ready for use. Script handles:
  - Detecting repository root from script location
  - Checking required files/directories exist
  - Backing up existing files before creating symlinks
  - Creating symlinks: `~/.zshrc` → `foundation/zsh/.zshrc` and `~/.zshrc.d/` → `foundation/zsh/.zshrc.d/`
- `AGENTS.md` updated to document that `setup.sh` is included in the repository and how to use it.

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
  - `zsh/.zshrc.d/01-env.zsh`
  - `zsh/.zshrc.d/02-path.zsh`
  - `zsh/.zshrc.d/10-mise.zsh`
  - `zsh/.zshrc.d/90-prompt.zsh`
