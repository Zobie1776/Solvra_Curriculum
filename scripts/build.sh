#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
TARGET_ARG=${1:-}

if [[ -z "${TARGET_ARG}" ]]; then
  echo "Usage: ./scripts/build.sh <path-to-.svs-or-.svc>" >&2
  exit 1
fi

TARGET_PATH=$TARGET_ARG
if [[ ! "${TARGET_PATH}" = /* ]]; then
  TARGET_PATH="${ROOT}/${TARGET_PATH}"
fi

if [[ ! -f "${TARGET_PATH}" ]]; then
  echo "Error: target file not found -> ${TARGET_PATH}" >&2
  exit 1
fi

mkdir -p "${ROOT}/logs" "${ROOT}/build/compiled"

RELATIVE_PATH=${TARGET_PATH#${ROOT}/}
LESSON_ID=$(echo "${RELATIVE_PATH%.*}" | sed 's#[/ ]#_#g')
LOG_FILE="${ROOT}/logs/${LESSON_ID}.log"

GREEN="\033[32m"
BLUE="\033[34m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

exec > >(tee -a "${LOG_FILE}") 2>&1

echo -e "${BLUE}==> Solvra build runner${RESET}"
echo -e "${BLUE}Target:${RESET} ${RELATIVE_PATH}"
echo -e "${BLUE}Log:${RESET} logs/${LESSON_ID}.log"
echo

MANIFEST="${ROOT}/Solvra_pkg/Cargo.toml"
EXT="${TARGET_PATH##*.}"

if [[ "${EXT}" == "svs" ]]; then
  echo -e "${YELLOW}Compiling to bytecode (.svc)...${RESET}"
  cargo run --quiet --manifest-path "${MANIFEST}" --bin solvra_compile -- "${TARGET_PATH}"
  COMPILED_SOURCE="${TARGET_PATH%.*}.svc"
  if [[ -f "${COMPILED_SOURCE}" ]]; then
    DEST="${ROOT}/build/compiled/${RELATIVE_PATH%.*}.svc"
    mkdir -p "$(dirname "${DEST}")"
    mv "${COMPILED_SOURCE}" "${DEST}"
    echo -e "${GREEN}Saved bytecode:${RESET} build/compiled/${RELATIVE_PATH%.*}.svc"
  fi
  echo -e "${YELLOW}Running source with solvrascript...${RESET}"
  cargo run --quiet --manifest-path "${MANIFEST}" --bin solvrascript -- "${TARGET_PATH}"
elif [[ "${EXT}" == "svc" ]]; then
  echo -e "${YELLOW}Executing compiled module with solvrascript...${RESET}"
  cargo run --quiet --manifest-path "${MANIFEST}" --bin solvrascript -- "${TARGET_PATH}"
else
  echo -e "${RED}Unsupported file extension: .${EXT}${RESET}" >&2
  exit 1
fi

echo -e "${GREEN}Build runner finished successfully.${RESET}"
