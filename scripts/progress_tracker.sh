#!/usr/bin/env bash
#==================================================
# File: progress_tracker.sh
#==================================================
# Author: ZobieLabs
# License: Duality Public License (DPL v1.0)
# Goal: Track lesson completion progress
# Objective: Parse logs and track which lessons were completed
#==================================================

#==================================================
# Import & Modules
#==================================================

set -euo pipefail

#==================================================
# Section 1.0 - Variables & Paths
#==================================================

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
LOG_DIR="${ROOT}/logs"
SESSION_LOG="${LOG_DIR}/learn_session.log"
PROGRESS_LOG="${LOG_DIR}/progress.csv"

GREEN="\033[32m"
BLUE="\033[34m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

#==================================================
# Section 2.0 - Logging
#==================================================

mkdir -p "$LOG_DIR"

# Initialize progress CSV if it doesn't exist
if [ ! -f "$PROGRESS_LOG" ]; then
  echo "timestamp,lesson_path,status" > "$PROGRESS_LOG"
fi

#==================================================
# Section 3.0 - Parse Session Log
#==================================================

if [ ! -f "$SESSION_LOG" ]; then
  echo -e "${YELLOW}No session log found. Run ./scripts/learn.sh first.${RESET}"
  exit 0
fi

# Extract completed lessons from session log
completed_count=0
while IFS= read -r line; do
  if echo "$line" | grep -q "complete "; then
    lesson_path=$(echo "$line" | sed 's/.*complete //')
    timestamp=$(echo "$line" | grep -oP '^\[\K[^\]]+')
    echo "${timestamp},${lesson_path},completed" >> "$PROGRESS_LOG"
    ((completed_count++))
  fi
done < "$SESSION_LOG"

#==================================================
# Section 4.0 - Output Summary
#==================================================

printf "${BLUE}========================================${RESET}\n"
printf "${BLUE}📊 Progress Summary${RESET}\n"
printf "${BLUE}========================================${RESET}\n"

# Count unique completed lessons
if [ -f "$PROGRESS_LOG" ]; then
  total_unique=$(tail -n +2 "$PROGRESS_LOG" | cut -d',' -f2 | sort -u | wc -l)
  total_completions=$(tail -n +2 "$PROGRESS_LOG" | wc -l)

  printf "${GREEN}✓ Unique lessons completed: %d${RESET}\n" "$total_unique"
  printf "${BLUE}Total completions (including repeats): %d${RESET}\n" "$total_completions"

  printf "\n${YELLOW}Recent completions:${RESET}\n"
  tail -5 "$PROGRESS_LOG" | tail -n +2 | while IFS=',' read -r ts lesson status; do
    printf "  ${GREEN}✓${RESET} %s - %s\n" "$lesson" "$ts"
  done
else
  printf "${YELLOW}No progress data yet.${RESET}\n"
fi

#--------------------------------------------------
# End comments: Tracks which lessons were completed
# @ZNOTE: Output a summary at the end of each session
#--------------------------------------------------

#==================================================
# End of file
#==================================================
