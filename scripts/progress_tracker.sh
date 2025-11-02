#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
LESSON_PATH=${1:-}
STATUS=${2:-}
NOTE=${3:-}

if [[ -z "$LESSON_PATH" || -z "$STATUS" ]]; then
  echo "Usage: ./scripts/progress_tracker.sh <lesson-path> <pass|fail> [note]" >&2
  exit 1
fi

STATUS_LOWER=$(echo "$STATUS" | tr '[:upper:]' '[:lower:]')
if [[ "$STATUS_LOWER" != "pass" && "$STATUS_LOWER" != "fail" ]]; then
  echo "Status must be pass or fail" >&2
  exit 1
fi

mkdir -p "${ROOT}/logs"
LOG_FILE="${ROOT}/logs/progress.csv"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
ENTRY="${TIMESTAMP},${LESSON_PATH},${STATUS_LOWER},${NOTE}"

echo "$ENTRY" >> "$LOG_FILE"

GREEN="\033[32m"
RED="\033[31m"
BLUE="\033[34m"
RESET="\033[0m"

if [[ "$STATUS_LOWER" == "pass" ]]; then
  printf "${GREEN}Logged progress:${RESET} %s -> PASS\n" "$LESSON_PATH"
else
  printf "${RED}Logged progress:${RESET} %s -> FAIL\n" "$LESSON_PATH"
fi

PASS_COUNT=$(grep -c ",pass," "$LOG_FILE" 2>/dev/null || true)
FAIL_COUNT=$(grep -c ",fail," "$LOG_FILE" 2>/dev/null || true)
TOTAL=$((PASS_COUNT + FAIL_COUNT))

printf "${BLUE}Totals:${RESET} %d entries (%d pass / %d fail)\n" "$TOTAL" "$PASS_COUNT" "$FAIL_COUNT"
