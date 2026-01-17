#!/usr/bin/env bash
set -euo pipefail

json_input=$(cat)
timestamp=$(date -Iseconds)
log_file="$HOME/.local/state/cursor/reflog.jsonl"

mkdir -p "$(dirname "$log_file")"

echo "{\"ts\":\"$timestamp\",\"input\":$json_input}" >> $HOME/.local/state/cursor/reflog.jsonl

exit 0
