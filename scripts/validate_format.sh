#!/usr/bin/env bash
#==================================================
# File: validate_format.sh
#==================================================
# Author: ZobieLabs
# License: Duality Public License (DPL v1.0)
# Goal: Validate Zobie.format compliance
# Objective: Check all .svs, .svc, and .sh files for required headers
#==================================================

#==================================================
# Import & Modules
#==================================================

set -euo pipefail

#==================================================
# Section 1.0 - Variables & Paths
#==================================================

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

GREEN="\033[32m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[34m"
RESET="\033[0m"

declare -i errors=0
declare -i warnings=0
declare -i checked=0

#==================================================
# Section 2.0 - Validation Logic
#==================================================

check_file() {
  local file=$1
  local rel_path="${file#${ROOT}/}"

  ((checked++))

  # Required headers
  local has_file=false
  local has_author=false
  local has_license=false
  local has_goal=false
  local has_objective=false

  while IFS= read -r line; do
    if echo "$line" | grep -q "^# File:"; then has_file=true; fi
    if echo "$line" | grep -q "^# Author:"; then has_author=true; fi
    if echo "$line" | grep -q "^# License:"; then has_license=true; fi
    if echo "$line" | grep -q "^# Goal:"; then has_goal=true; fi
    if echo "$line" | grep -q "^# Objective:"; then has_objective=true; fi
  done < "$file"

  local missing=""
  if ! $has_file; then missing="${missing}File: "; fi
  if ! $has_author; then missing="${missing}Author: "; fi
  if ! $has_license; then missing="${missing}License: "; fi
  if ! $has_goal; then missing="${missing}Goal: "; fi
  if ! $has_objective; then missing="${missing}Objective: "; fi

  if [[ -n "$missing" ]]; then
    printf "${RED}✗ %s${RESET}\n" "$rel_path"
    printf "  ${YELLOW}Missing headers: %s${RESET}\n" "$missing"
    ((errors++))
  else
    printf "${GREEN}✓ %s${RESET}\n" "$rel_path"
  fi
}

#==================================================
# Section 3.0 - File Discovery
#==================================================

printf "${BLUE}========================================${RESET}\n"
printf "${BLUE}🔍 Zobie.format Validation${RESET}\n"
printf "${BLUE}========================================${RESET}\n\n"

# Check all .svs files
printf "${YELLOW}Checking .svs files...${RESET}\n"
while IFS= read -r file; do
  check_file "$file"
done < <(find "$ROOT/lessons" -type f -name "*.svs" | sort)

# Check all .svc files
printf "\n${YELLOW}Checking .svc files...${RESET}\n"
while IFS= read -r file; do
  check_file "$file"
done < <(find "$ROOT/lessons" -type f -name "*.svc" | sort)

# Check all .sh files
printf "\n${YELLOW}Checking .sh files...${RESET}\n"
while IFS= read -r file; do
  check_file "$file"
done < <(find "$ROOT/scripts" -type f -name "*.sh" | sort)

#==================================================
# Section 4.0 - Summary
#==================================================

printf "\n${BLUE}========================================${RESET}\n"
printf "${BLUE}Summary${RESET}\n"
printf "${BLUE}========================================${RESET}\n"
printf "Files checked: %d\n" "$checked"
printf "${GREEN}Valid: %d${RESET}\n" $((checked - errors))
printf "${RED}Invalid: %d${RESET}\n" "$errors"

if [[ $errors -eq 0 ]]; then
  printf "\n${GREEN}✓ All files are Zobie.format compliant!${RESET}\n"
  exit 0
else
  printf "\n${RED}✗ %d file(s) missing required headers${RESET}\n" "$errors"
  exit 1
fi

#--------------------------------------------------
# End comments: Validates Zobie.format compliance across codebase
# @ZNOTE: Essential for maintaining code quality and documentation standards
#--------------------------------------------------

#==================================================
# End of file
#==================================================
