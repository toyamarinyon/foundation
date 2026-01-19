## CONTINUITY.md

### Goal (incl. success criteria):
- Manage personal dotfiles in this repo (primarily zsh) and Cursor user-level hooks.
- Improve Cursor `beforeShellExecution` hook so mise shims are initialized once per conversation (via marker file), avoiding repeated manual `eval "$(mise activate zsh --shims)"` prefixes.
- Update hook so marker creation happens inside the hook when the command itself is `eval "$(mise activate zsh --shims)"` (marker not in response).
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
- `zsh/.zshrc` is a self-contained configuration file (mise init + basic completion/colors/prompt).
- `zsh/.zshrc` initializes mise quietly:
  - If `mise` is on `PATH`, it runs `eval "$(mise activate zsh)"`.
  - Else, if `$HOME/.local/bin/mise` exists and is executable, it activates via that path.
- `zsh/.zshrc` currently autoloads `compinit` but does not call it (so completion may not be initialized).
- `zsh/.zshrc.d/` fragment directory is not used.
- `setup.sh` will symlink Cursor hook config at user level: `~/.cursor/hooks.json` and `~/.cursor/hooks/`.
- User added `agent-browser` to guarded command list in `cursor/hooks/ensure-mise-execution.sh`.
- `cursor/hooks/ensure-mise-execution.sh` denies combined `eval "$(mise activate zsh --shims)" && <cmd>` and provides English 2-step guidance; if already initialized, it denies with "init not needed, run only the remaining command."

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
- Updated `cursor/hooks/ensure-mise-execution.sh` to gate mise initialization per conversation:
  - Extracts `conversation_id` from hook input and uses marker file under `$HOME/.local/state/cursor/init-mise/<conversation_id>`.
  - If marker is missing, denies guarded commands and instructs a one-time bootstrap command: `eval "$(mise activate zsh --shims)"` then re-run the original command.
  - If marker exists, allows immediately (no need to prefix every time).
  - Fixed hook JSON output to always emit a single valid JSON object (no multi-line / trailing comma output).
  - Ensured the suggested bootstrap command uses `$HOME/...` (not an expanded absolute path) to avoid embedding user-specific paths.
- Updated hook so marker creation is done only when the command itself is `eval "$(mise activate zsh --shims)"` (not via deny response).
- Sanity-tested marker creation via eval command (marker created, hook returned allow).
- Reverted zsh fragment approach back to a single-file `zsh/.zshrc`.
- Updated `AGENTS.md` to reflect single-file zsh config (no fragments).
- Updated `cursor/hooks/ensure-mise-execution.sh` to detect combined mise-init commands and deny with English 2-step guidance (init/no-init depending on marker).

### Now:
- Ready for review; hook messages are now in English (manual verification not run to avoid writing outside repo).

### Next:
- After each file edit in this repo, update `CONTINUITY.md` immediately with what changed.
- If desired, sanity-test by piping representative JSON into the hook script and confirming JSON output (`allow` vs `deny`) is correct.

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
