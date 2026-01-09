#!/usr/bin/env bash
set -euo pipefail

# Read hook input
input="$(cat)"
command=""
if command -v jq >/dev/null 2>&1; then
  command="$(
    echo "$input" | jq -r '
      (.command // .commandLine // .shellCommand // .shell_command // .argv // empty)
      | if type == "array" then join(" ")
        elif type == "string" then .
        else empty
        end
    ' 2>/dev/null || true
  )"
fi
if [[ -z "${command}" ]]; then
  command="$(
    printf '%s' "$input" | sed -nE \
      's/.*"(command|commandLine|shellCommand|shell_command)"[[:space:]]*:[[:space:]]*"([^"]*)".*/\2/p' \
      | head -n 1
  )"
fi

# If we still can't extract a command, fail closed (avoid accidental allow-bypass)
if [[ -z "${command}" ]]; then
  user_message="Unable to extract command from Cursor hook input."
  agent_message="This hook could not extract a command from the provided JSON input. Ensure Cursor is sending a 'command' field, or install jq for reliable parsing."
  jq -n --arg user_message "$user_message" --arg agent_message "$agent_message" \
    '{permission:"deny", user_message:$user_message, agent_message:$agent_message}'
  exit 0
fi

# Commands to guard.
# Add new tools here (one per line).
GUARDED_COMMANDS=(
  node
  npm
  pnpm
  npx
)

# Best-effort log (stdout must remain pure JSON for Cursor)
ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
LOG_FILE="${ROOT_DIR}/cursor-beforeShellExecution.log"
{
  echo "-----"
  echo "ts=$(date '+%Y-%m-%dT%H:%M:%S%z' 2>/dev/null || date)"
  echo "hook=beforeShellExecution"
  echo "cmd_extracted=${command}"
} >>"$LOG_FILE" 2>/dev/null || true

# Detect guarded commands anywhere in the command line (Cursor may wrap commands like: zsh -lc "node -v")
hit_cmd=""
for guarded in "${GUARDED_COMMANDS[@]}"; do
  if printf '%s' "$command" | grep -Eiq "(^|[[:space:];&|()])${guarded}([[:space:]]|$)"; then
    hit_cmd="$guarded"
    break
  fi
done

# Not a guarded command → allow
if [[ -z "$hit_cmd" ]]; then
  jq -n '{"permission":"allow"}'
  exit 0
fi

# Allow if the command itself bootstraps mise shims before running the guarded command.
# Why: `eval "$(mise activate ... --shims)" && node ...` won't affect `command -v node`
# until the eval is executed, but we still want to allow this usage.
if printf '%s' "$command" | grep -Eiq \
  "mise[[:space:]]+activate[[:space:]].*--shims.*(^|[[:space:];&|()])${hit_cmd}([[:space:]]|$)"; then
  jq -n '{"permission":"allow"}'
  exit 0
fi

# Also allow mise subcommands that execute the guarded command inside mise-managed env.
# Examples:
# - mise x -- node -v
# - mise exec -- node -v
if printf '%s' "$command" | grep -Eiq \
  "(^|[[:space:];&|()])mise[[:space:]]+(x|exec)[[:space:]].*--[[:space:]]*${hit_cmd}([[:space:]]|$)"; then
  jq -n '{"permission":"allow"}'
  exit 0
fi

# Resolve the actual binary path
BIN_PATH="$(command -v "$hit_cmd" 2>/dev/null || true)"

# Allow if the command is executed via mise shims
if [[ "$BIN_PATH" == *"/mise/shims/"* ]]; then
  jq -n '{"permission":"allow"}'
  exit 0
fi

# Block execution if not running under mise
{
  echo "bin_path=${BIN_PATH}"
  echo "decision=deny"
} >>"$LOG_FILE" 2>/dev/null || true

user_message="This project requires Node.js tooling to be executed via mise."
prefix='eval "$(mise activate zsh --shims)" && '
agent_message="The command '$command' is not running under mise. Prefix the command with: ${prefix}${command}"

jq -n --arg user_message "$user_message" --arg agent_message "$agent_message" \
  '{permission:"deny", user_message:$user_message, agent_message:$agent_message}'
