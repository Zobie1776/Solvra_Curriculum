#!/usr/bin/env bash
#==================================================
# File: learn.sh
#==================================================
# Author: ZobieLabs
# License: Duality Public License (DPL v1.0)
# Goal: Interactive lesson menu for SolvraScript curriculum
# Objective: Dynamically scan and present lessons from tier1-4 folders
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
# Section 2.0 - Menu Logic
#==================================================

function render_menu() {
  printf "${BLUE}========================================${RESET}\n"
  printf "${BLUE}📚 SolvraScript Curriculum${RESET}\n"
  printf "${BLUE}========================================${RESET}\n"

  local idx=1

  for tier_dir in "${ROOT}/lessons"/tier*; do
    if [ ! -d "$tier_dir" ]; then continue; fi

    tier_name=$(basename "$tier_dir" | sed 's/_/ /g' | sed 's/tier/Tier/')

    printf "\n${YELLOW}%s:${RESET}\n" "$tier_name"

    # Find all .svs and .svc files in examples, exercises, and root
    while IFS= read -r lesson_file; do
      lesson_rel="${lesson_file#${ROOT}/}"
      lesson_title=$(basename "$lesson_file" .svs | basename .svc | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g')
      printf " ${GREEN}%2d${RESET}) %s\n" "$idx" "$lesson_title"
      LESSONS[$idx]="$lesson_rel"
      ((idx++))
    done < <(find "$tier_dir" -type f \( -name "*.svs" -o -name "*.svc" \) | sort)
  done

  printf "\n ${YELLOW}q${RESET}) Quit\n"
}

#==================================================
# Section 3.0 - Logging
#==================================================

mkdir -p "${ROOT}/logs"

function log_event() {
  local message=$1
  printf "[%s] %s\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$message" >> "$LOG_FILE"
}

log_event "session_start"

#==================================================
# Section 4.0 - Runtime Execution
#==================================================

declare -A LESSONS

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
# End comments: Dynamically builds lesson menu from filesystem structure
# @ZNOTE: Supports scalable curriculum expansion without code changes
#--------------------------------------------------

#==================================================
# End of file
#==================================================
