#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
LOG_FILE="${ROOT}/logs/learn_session.log"

mkdir -p "${ROOT}/logs"

GREEN="\033[32m"
BLUE="\033[34m"
YELLOW="\033[33m"
MAGENTA="\033[35m"
RED="\033[31m"
RESET="\033[0m"

mapfile -t LESSON_KEYS <<'LESSONS'
1|Tier 1|Hello World Warmup|lessons/tier1_foundations/examples/01_hello_world.svs
2|Tier 1|Variables & Types|lessons/tier1_foundations/examples/02_variables.svs
3|Tier 2|Async Programming|lessons/tier2_intermediate/async_programming.svs
4|Tier 2|Memory Basics|lessons/tier2_intermediate/memory_basics.svs
5|Tier 3|Async Scheduler|lessons/tier3_advanced/async_scheduler.svs
6|Tier 4|AI Module Integration|lessons/tier4_expert/ai_module_integration.svs
LESSONS

function render_menu() {
  printf "${BLUE}========================================${RESET}\n"
  printf "${BLUE}What do you want to learn today?${RESET}\n"
  printf "${BLUE}========================================${RESET}\n"
  for line in "${LESSON_KEYS[@]}"; do
    IFS='|' read -r key tier title path <<<"$line"
    printf " ${YELLOW}%s${RESET}) %-8s %s\n" "$key" "$tier" "$title"
  done
  printf " ${YELLOW}q${RESET}) Quit\n"
}

function log_event() {
  local message=$1
  printf "[learn] %s\n" "$message" >> "$LOG_FILE"
}

while true; do
  render_menu
  printf "${MAGENTA}Select an option:${RESET} "
  read -r choice || exit 0
  case "$choice" in
    q|Q)
      printf "${GREEN}See you next session!${RESET}\n"
      log_event "session_end"
      exit 0
      ;;
    "")
      continue
      ;;
    *)
      found=false
      for line in "${LESSON_KEYS[@]}"; do
        IFS='|' read -r key tier title path <<<"$line"
        if [[ "$choice" == "$key" ]]; then
          found=true
          printf "${GREEN}Launching:%s %s${RESET}\n" "$tier" "$title"
          log_event "launch ${path}"
          SOLVRA_CURRICULUM_IMPORT="" "${ROOT}/scripts/build.sh" "$path"
          printf "${GREEN}Lesson complete. Check logs for reflections.${RESET}\n"
          log_event "complete ${path}"
          break
        fi
      done
      if [[ "$found" == false ]]; then
        printf "${RED}Invalid choice. Try again.${RESET}\n"
      fi
      ;;
  esac
  printf "\n"
done
