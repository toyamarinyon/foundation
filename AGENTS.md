## AGENTS.md

This repository contains **personal shell dotfiles (mainly zsh)**.

- **Current source of truth**: `zsh/`

## Important rules

- **Do not embed absolute paths**
  - Avoid user-specific paths (e.g. `/Users/...`). Prefer `command -v`, `$HOME`, or other environment-based resolution.
- **Add zsh config as “fragments”**
  - `zsh/.zshrc` is a thin loader that sources `~/.zshrc.d/*.zsh` in order.
  - Changes should usually be done by adding/editing files under `zsh/.zshrc.d/`.
  - Do not break the existing ordering conventions (`00-`, `01-`, `10-`, `90-`, etc.).
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
- Symlink `~/.zshrc.d/` → `foundation/zsh/.zshrc.d/`
- Back up any existing files before creating symlinks
- Skip creation if symlinks already point to the correct location

## What agents should / should not do

- **Do**
  - Improve `zsh/.zshrc` and `zsh/.zshrc.d/*.zsh` (portability, readability, safety)
- **Do not**
  - Write directly into the user's home directory (i.e., do not change files outside this repository)

## Quick smoke tests

After zsh changes, at minimum verify:

- `zsh -i -c 'echo ok'` succeeds
- No errors on a fresh shell startup (e.g. around `compinit`)


## Continuity Ledger (compaction-safe)
Maintain a single Continuity Ledger for this workspace in `CONTINUITY.md`. The ledger is the canonical session briefing designed to survive context compaction; do not rely on earlier chat text unless it’s reflected in the ledger.

### How it works
- At the start of every assistant turn: read `CONTINUITY.md`, update it to reflect the latest goal/constraints/decisions/state, then proceed with the work.
- **After every file edit: update `CONTINUITY.md` immediately** to reflect the change before proceeding to the next task. Skipping this breaks session continuity and makes context unreliable.
- Keep it short and stable: facts only, no transcripts. Prefer bullets. Mark uncertainty as `UNCONFIRMED` (never guess).
- If you notice missing recall or a compaction/summary event: refresh/rebuild the ledger from visible context, mark gaps `UNCONFIRMED`, ask up to 1–3 targeted questions, then continue.

### `functions.update_plan` vs the Ledger
- `functions.update_plan` is for short-term execution scaffolding while you work (a small 3–7 step plan with pending/in_progress/completed).
- `CONTINUITY.md` is for long-running continuity across compaction (the “what/why/current state”), not a step-by-step task list.
- Keep them consistent: when the plan or state changes, update the ledger at the intent/progress level (not every micro-step).

### In replies
- Begin with a brief “Ledger Snapshot” (Goal + Now/Next + Open Questions). Print the full ledger only when it materially changes or when the user asks.

### `CONTINUITY.md` format (keep headings)
- Goal (incl. success criteria):
- Constraints/Assumptions:
- Key decisions:
- State:
- Done:
- Now:
- Next:
- Open questions (UNCONFIRMED if needed):
- Working set (files/ids/commands):
