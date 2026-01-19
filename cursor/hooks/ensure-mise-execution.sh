#!/usr/bin/env bash
set -euo pipefail

# Minimal JSON escaping (so jq is optional for output)
json_escape() {
  # Escapes backslash, double-quote, and newlines for embedding in JSON strings.
  local s="${1-}"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  s="${s//$'\n'/\\n}"
  printf '%s' "$s"
}

emit_allow() {
  printf '%s\n' '{"permission":"allow"}'
}

emit_deny() {
  local user_message="${1-}"
  local agent_message="${2-}"
  printf '{"permission":"deny","user_message":"%s","agent_message":"%s"}\n' \
    "$(json_escape "$user_message")" \
    "$(json_escape "$agent_message")"
}

# Read hook input
input="$(cat)"
command=""
conversation_id=""
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
  conversation_id="$(
    echo "$input" | jq -r '(.conversation_id // empty)' 2>/dev/null || true
  )"
fi
if [[ -z "${command}" ]]; then
  command="$(
    printf '%s' "$input" | sed -nE \
      's/.*"(command|commandLine|shellCommand|shell_command)"[[:space:]]*:[[:space:]]*"([^"]*)".*/\2/p' \
      | head -n 1
  )"
fi
if [[ -z "${conversation_id}" ]]; then
  conversation_id="$(
    printf '%s' "$input" | sed -nE \
      's/.*"conversation_id"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/p' \
      | head -n 1
  )"
fi

# Sanitize conversation_id to a safe filename component (defense-in-depth)
safe_conversation_id="$(
  printf '%s' "${conversation_id}" | tr -cd 'A-Za-z0-9._-'
)"

# If we still can't extract a command, fail closed (avoid accidental allow-bypass)
if [[ -z "${command}" ]]; then
  user_message="Unable to extract command from Cursor hook input."
  agent_message="This hook could not extract a command from the provided JSON input. Ensure Cursor is sending a 'command' field, or install jq for reliable parsing."
  emit_deny "$user_message" "$agent_message"
  exit 0
fi

# Per-conversation mise bootstrap marker.
# If marker exists, we allow without further checks (you've already initialized mise in this conversation).
STATE_DIR_FS="${HOME}/.local/state/cursor/init-mise"
STATE_DIR_MSG='$HOME/.local/state/cursor/init-mise'
STATE_FILE_FS=""
STATE_FILE_MSG=""
if [[ -n "${safe_conversation_id}" ]]; then
  STATE_FILE_FS="${STATE_DIR_FS}/${safe_conversation_id}"
  STATE_FILE_MSG="${STATE_DIR_MSG}/${safe_conversation_id}"
fi
# If the command chains mise bootstrap and another command, deny and guide 2-step execution.
if [[ "${command}" =~ ^[[:space:]]*eval[[:space:]]+['\"]\$\([[:space:]]*mise[[:space:]]+activate[[:space:]]+zsh[[:space:]]+--shims[[:space:]]*\)['\"][[:space:]]*(\&\&|;)[[:space:]]*(.+)$ ]]; then
  bootstrap_cmd='eval "$(mise activate zsh --shims)"'
  rest_cmd="${BASH_REMATCH[3]}"
  if [[ -n "${STATE_FILE_FS}" && -f "${STATE_FILE_FS}" ]]; then
    user_message="mise is already initialized for this conversation."
    agent_message="Initialization is not needed. Run only this command:\n${rest_cmd}"
  else
    user_message="Initializing mise for this conversation (one-time)."
    agent_message="Run this command first:\n${bootstrap_cmd}\nThen run this command:\n${rest_cmd}"
  fi
  emit_deny "$user_message" "$agent_message"
  exit 0
fi
if [[ -n "${STATE_FILE_FS}" && -f "${STATE_FILE_FS}" ]]; then
  emit_allow
  exit 0
fi

# If the command is the one-time mise bootstrap, create the marker here.
if printf '%s' "$command" | grep -Eiq \
  "^[[:space:]]*eval[[:space:]]+['\"]\\$\\([[:space:]]*mise[[:space:]]+activate[[:space:]]+zsh[[:space:]]+--shims[[:space:]]*\\)['\"][[:space:]]*$"; then
  if [[ -n "${STATE_FILE_FS}" ]]; then
    mkdir -p "${STATE_DIR_FS}" 2>/dev/null || true
    : >"${STATE_FILE_FS}" 2>/dev/null || true
  fi
  emit_allow
  exit 0
fi

# Commands to guard.
# Add new tools here (one per line).
GUARDED_COMMANDS=(
  node
  npm
  pnpm
  npx
  agent-browser
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
  emit_allow
  exit 0
fi
# Also allow mise subcommands that execute the guarded command inside mise-managed env.
# Examples:
# - mise x -- node -v
# - mise exec -- node -v
if printf '%s' "$command" | grep -Eiq \
  "(^|[[:space:];&|()])mise[[:space:]]+(x|exec)[[:space:]].*--[[:space:]]*${hit_cmd}([[:space:]]|$)"; then
  emit_allow
  exit 0
fi

# Resolve the actual binary path
BIN_PATH="$(command -v "$hit_cmd" 2>/dev/null || true)"

# Allow if the command is executed via mise shims
if [[ "$BIN_PATH" == *"/mise/shims/"* ]]; then
  emit_allow
  exit 0
fi

# If we have a conversation id but no marker yet, deny and instruct a one-time bootstrap:
# 1) eval mise shims, 2) run the original command.
if [[ -n "${STATE_FILE_FS}" && -n "${STATE_FILE_MSG}" ]]; then
  user_message="Initializing mise shims for this conversation (one-time)."
  bootstrap_cmd="eval \"\$(mise activate zsh --shims)\""
  agent_message="Run once to initialize mise shims:\n${bootstrap_cmd}\nThen re-run your original command."
  emit_deny "$user_message" "$agent_message"
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

emit_deny "$user_message" "$agent_message"
