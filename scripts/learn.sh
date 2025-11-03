#!/usr/bin/env bash
#==================================================
# File: learn.sh
#==================================================
# Author: ZobieLabs
# License: Duality Public License (DPL v1.0)
# Goal: Interactive lesson launcher for SolvraScript Curriculum
# Objective: Auto-detect lessons, parse headers, and render dynamic menu
#==================================================

#==================================================
# Import & Modules
#==================================================

set -euo pipefail

#==================================================
# Section 1.0 - Variables & Paths
#==================================================

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
LOG_FILE="${ROOT}/logs/learn_session.log"

GREEN="\033[32m"
BLUE="\033[34m"
YELLOW="\033[33m"
MAGENTA="\033[35m"
RED="\033[31m"
RESET="\033[0m"

#==================================================
# Section 2.0 - Header Parsing
#==================================================

# Extract lesson title from // Goal: line in file
parse_lesson_title() {
  local file=$1
  local goal_line

  # Try to find // Goal: line (case-insensitive)
  goal_line=$(grep -i "^// Goal:" "$file" 2>/dev/null | head -1 || true)

  if [[ -n "$goal_line" ]]; then
    # Extract everything after "// Goal:" and trim whitespace
    echo "$goal_line" | sed -E 's|^//[[:space:]]*Goal:[[:space:]]*||i' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
  else
    # Fallback: use filename without extension, formatted nicely
    basename "$file" .svs | sed 's/\.svc$//' | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g'
  fi
}

#==================================================
# Section 3.0 - Menu Logic
#==================================================

declare -A LESSONS
declare -A LESSON_TITLES

function scan_lessons() {
  local idx=1

  # Scan all tier directories
  for tier_dir in "${ROOT}/lessons"/tier*; do
    if [ ! -d "$tier_dir" ]; then continue; fi

    tier_name=$(basename "$tier_dir")

    # Find all .svs and .svc files (case-insensitive)
    while IFS= read -r lesson_file; do
      if [ ! -f "$lesson_file" ]; then continue; fi

      lesson_rel="${lesson_file#${ROOT}/}"
      lesson_title=$(parse_lesson_title "$lesson_file")

      LESSONS[$idx]="$lesson_rel"
      LESSON_TITLES[$idx]="${tier_name}|${lesson_title}"
      ((idx++))
    done < <(find "$tier_dir" -type f \( -iname "*.svs" -o -iname "*.svc" \) 2>/dev/null | sort)
  done
}

function render_menu() {
  printf "${BLUE}========================================${RESET}\n"
  printf "${BLUE}📚 SolvraScript Curriculum${RESET}\n"
  printf "${BLUE}========================================${RESET}\n"

  local current_tier=""

  for idx in $(echo "${!LESSON_TITLES[@]}" | tr ' ' '\n' | sort -n); do
    local tier_and_title="${LESSON_TITLES[$idx]}"
    local tier_name="${tier_and_title%%|*}"
    local lesson_title="${tier_and_title#*|}"

    # Format tier name nicely
    local tier_display=$(echo "$tier_name" | sed 's/_/ /g' | sed 's/tier/Tier/')

    # Print tier header if this is a new tier
    if [[ "$tier_name" != "$current_tier" ]]; then
      printf "\n${YELLOW}%s:${RESET}\n" "$tier_display"
      current_tier="$tier_name"
    fi

    printf " ${GREEN}%2d${RESET}) %s\n" "$idx" "$lesson_title"
  done

  printf "\n ${YELLOW}q${RESET}) Quit\n"
}

#==================================================
# Section 4.0 - Logging
#==================================================

mkdir -p "${ROOT}/logs"

function log_event() {
  local message=$1
  printf "[%s] %s\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$message" >> "$LOG_FILE"
}

log_event "session_start"

#==================================================
# Section 5.0 - Runtime Execution
#==================================================

# Scan lessons once at startup
scan_lessons

while true; do
  render_menu
  printf "\n${MAGENTA}Select an option:${RESET} "
  read -r choice || exit 0

  case "$choice" in
    q|Q)
      printf "${GREEN}✨ See you next session!${RESET}\n"
      log_event "session_end"
      exit 0
      ;;
    "")
      continue
      ;;
    *)
      if [[ -n "${LESSONS[$choice]:-}" ]]; then
        printf "${GREEN}▶ Launching: ${LESSONS[$choice]}${RESET}\n"
        log_event "launch ${LESSONS[$choice]}"
        "${ROOT}/scripts/build.sh" "${LESSONS[$choice]}"
        printf "${GREEN}✓ Lesson complete. Check logs for details.${RESET}\n"
        log_event "complete ${LESSONS[$choice]}"
      else
        printf "${RED}❌ Invalid choice. Try again.${RESET}\n"
      fi
      ;;
  esac
  printf "\n"
done

#--------------------------------------------------
# End comments: Parses lesson metadata and renders interactive menu
# @ZNOTE: Dynamically reads // Goal: headers for proper lesson titles
#--------------------------------------------------

#==================================================
# End of file
#==================================================
