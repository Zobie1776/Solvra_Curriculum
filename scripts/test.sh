#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
TARGET=${1:-all}
MANIFEST="${ROOT}/Solvra_pkg/Cargo.toml"

declare -a CASES

declare -A TIER_MAP=(
  [tier1]="lessons/tier1_foundations/tests/test_foundations.svs lessons/tier1_foundations/tests/test_output_check.svc"
  [tier2]="lessons/tier2_intermediate/tests/test_intermediate.svs"
  [tier3]="lessons/tier3_advanced/tests/test_advanced.svs lessons/tier3_advanced/compile_pipeline.svc"
  [tier4]="lessons/tier4_expert/tests/test_expert.svs lessons/tier4_expert/solvra_runtime_internals.svc"
)

add_cases() {
  local tier=$1
  local entries=${TIER_MAP[$tier]:-}
  if [[ -z "$entries" ]]; then
    echo "Unknown tier: $tier" >&2
    exit 1
  fi
  for file in $entries; do
    CASES+=("$tier|$file")
  done
}

if [[ "$TARGET" == "all" ]]; then
  for tier in "${!TIER_MAP[@]}"; do
    add_cases "$tier"
  done
else
  add_cases "$TARGET"
fi

mkdir -p "${ROOT}/logs"

GREEN="\033[32m"
RED="\033[31m"
BLUE="\033[34m"
YELLOW="\033[33m"
RESET="\033[0m"

printf "${BLUE}==> Running Solvra curriculum tests (%s)${RESET}\n" "$TARGET"

declare -i passed=0

declare -i total=0

for entry in "${CASES[@]}"; do
  IFS='|' read -r tier file <<<"$entry"
  total+=1
  REL_PATH="$file"
  ABS_PATH="$file"
  if [[ ! "$ABS_PATH" = /* ]]; then
    ABS_PATH="${ROOT}/${file}"
  fi
  if [[ ! -f "$ABS_PATH" ]]; then
    printf "${RED}Missing file:${RESET} %s\n" "$REL_PATH"
    continue
  fi

  LESSON_ID=$(echo "${REL_PATH%.*}" | sed 's#[/ ]#_#g')
  LOG_FILE="${ROOT}/logs/test_${LESSON_ID}.log"

  printf "${YELLOW}-- %s :: %s${RESET}\n" "$tier" "$REL_PATH"

  set +e
  {
    printf "[test] tier=%s path=%s\n" "$tier" "$REL_PATH"
    EXT="${ABS_PATH##*.}"
    if [[ "$EXT" == "svs" ]]; then
      cargo run --quiet --manifest-path "${MANIFEST}" --bin solvrascript -- "$ABS_PATH"
    elif [[ "$EXT" == "svc" ]]; then
      cargo run --quiet --manifest-path "${MANIFEST}" --bin solvrascript -- "$ABS_PATH"
    else
      printf "Unsupported extension: %s\n" "$EXT" >&2
      exit 2
    fi
    printf "[result] success\n"
  } > >(tee -a "$LOG_FILE") 2>&1
  STATUS=$?
  set -e
  if [[ $STATUS -eq 0 ]]; then
    printf "${GREEN}PASS${RESET} %s\n" "$REL_PATH"
    passed+=1
  else
    printf "${RED}FAIL${RESET} %s (see logs/test_%s.log)\n" "$REL_PATH" "$LESSON_ID"
  fi

  printf "\n"
done

printf "${BLUE}Summary:${RESET} %d/%d passed\n" "$passed" "$total"
if (( passed == total )); then
  exit 0
else
  exit 1
fi
