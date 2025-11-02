#!/usr/bin/env bash
#==================================================
# File: test.sh
#==================================================
# Author: ZobieLabs
# License: Duality Public License (DPL v1.0)
# Goal: Run curriculum test suite
# Objective: Execute test files for all tiers or specific tier
#==================================================

#==================================================
# Import & Modules
#==================================================

set -euo pipefail

#==================================================
# Section 1.0 - Variables & Paths
#==================================================

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
TARGET=${1:-all}

GREEN="\033[32m"
RED="\033[31m"
BLUE="\033[34m"
YELLOW="\033[33m"
RESET="\033[0m"

#==================================================
# Section 2.0 - Runtime Detection
#==================================================

SOLVRA_SCRIPT_BIN=""

if [ -x "${ROOT}/solvra_script/bin/solvrascript" ]; then
  SOLVRA_SCRIPT_BIN="${ROOT}/solvra_script/bin/solvrascript"
elif [ -x "${ROOT}/../SolvraOS/target/debug/solvrascript" ]; then
  SOLVRA_SCRIPT_BIN="${ROOT}/../SolvraOS/target/debug/solvrascript"
else
  echo -e "${RED}[ERROR] SolvraScript VM not found. Build it first.${RESET}" >&2
  exit 1
fi

#==================================================
# Section 3.0 - Test Discovery
#==================================================

declare -a CASES

declare -A TIER_MAP=(
  [tier1]="lessons/tier1_foundations/tests"
  [tier2]="lessons/tier2_intermediate/tests"
  [tier3]="lessons/tier3_advanced/tests"
  [tier4]="lessons/tier4_expert/tests"
)

add_cases() {
  local tier=$1
  local test_dir=${TIER_MAP[$tier]:-}
  if [[ -z "$test_dir" ]] || [[ ! -d "${ROOT}/${test_dir}" ]]; then
    echo -e "${YELLOW}Warning: No test directory for $tier${RESET}" >&2
    return
  fi
  while IFS= read -r test_file; do
    CASES+=("$tier|${test_file#${ROOT}/}")
  done < <(find "${ROOT}/${test_dir}" -type f \( -name "*.svs" -o -name "*.svc" \) | sort)
}

if [[ "$TARGET" == "all" ]]; then
  for tier in tier1 tier2 tier3 tier4; do
    add_cases "$tier"
  done
else
  add_cases "$TARGET"
fi

#==================================================
# Section 4.0 - Test Execution
#==================================================

mkdir -p "${ROOT}/logs"

printf "${BLUE}========================================${RESET}\n"
printf "${BLUE}🧪 Running Solvra Curriculum Tests${RESET}\n"
printf "${BLUE}Target: %s${RESET}\n" "$TARGET"
printf "${BLUE}========================================${RESET}\n\n"

declare -i passed=0
declare -i total=0

for entry in "${CASES[@]}"; do
  IFS='|' read -r tier file <<<"$entry"
  total+=1

  ABS_PATH="${ROOT}/${file}"
  if [[ ! -f "$ABS_PATH" ]]; then
    printf "${RED}✗ Missing file:${RESET} %s\n" "$file"
    continue
  fi

  LESSON_ID=$(echo "${file%.*}" | sed 's#[/ ]#_#g')
  LOG_FILE="${ROOT}/logs/test_${LESSON_ID}.log"

  printf "${YELLOW}▸ %s :: %s${RESET}\n" "$tier" "$file"

  set +e
  "$SOLVRA_SCRIPT_BIN" "$ABS_PATH" > "$LOG_FILE" 2>&1
  STATUS=$?
  set -e

  if [[ $STATUS -eq 0 ]]; then
    printf "${GREEN}  ✓ PASS${RESET}\n"
    passed+=1
  else
    printf "${RED}  ✗ FAIL${RESET} (see logs/test_${LESSON_ID}.log)\n"
  fi

  printf "\n"
done

#==================================================
# Section 5.0 - Summary
#==================================================

printf "${BLUE}========================================${RESET}\n"
printf "${BLUE}Summary: %d/%d tests passed${RESET}\n" "$passed" "$total"
printf "${BLUE}========================================${RESET}\n"

if (( passed == total )); then
  printf "${GREEN}✓ All tests passed!${RESET}\n"
  exit 0
else
  printf "${RED}✗ Some tests failed.${RESET}\n"
  exit 1
fi

#--------------------------------------------------
# End comments: Validates lesson functionality
# @ZNOTE: Confirms all lessons execute correctly with SolvraScript VM
#--------------------------------------------------

#==================================================
# End of file
#==================================================
