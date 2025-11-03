#!/usr/bin/env bash
#==================================================
# File: build.sh
#==================================================
# Author: ZobieLabs
# License: Duality Public License (DPL v1.0)
# Goal: Build and execute SolvraScript lessons
# Objective: Dynamically locate SolvraScript runtime and execute .svs/.svc lessons
#==================================================

#==================================================
# Import & Modules
#==================================================

set -euo pipefail

#==================================================
# Section 1.0 - Variables & Paths
#==================================================

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
SOLVRA_SCRIPT_BIN=""
LOG_FILE=""

#==================================================
# Section 2.0 - Runtime Detection
#==================================================

# Try common VM paths
if [ ! -x "$SOLVRA_SCRIPT_BIN" ]; then
  if [ -x "${ROOT}/solvra_script/bin/solvrascript" ]; then
    SOLVRA_SCRIPT_BIN="${ROOT}/solvra_script/bin/solvrascript"
  elif [ -x "${ROOT}/../SolvraOS/target/debug/solvrascript" ]; then
    SOLVRA_SCRIPT_BIN="${ROOT}/../SolvraOS/target/debug/solvrascript"
  else
    echo "[ERROR] SolvraScript VM not found. Build it first:" >&2
    echo "    cd ../SolvraOS && cargo build -p solvrascript" >&2
    exit 1
  fi
fi

#==================================================
# Section 3.0 - Argument Validation
#==================================================

if [ $# -lt 1 ]; then
  echo "[ERROR] Missing lesson path argument." | tee -a "$LOG_FILE"
  exit 1
fi

LESSON_PATH="$1"

#==================================================
# Section 4.0 - Logging
#==================================================

mkdir -p "${ROOT}/logs"

RELATIVE_PATH=${LESSON_PATH#${ROOT}/}
LESSON_ID=$(echo "${RELATIVE_PATH%.*}" | sed 's#[/ ]#_#g')
LOG_FILE="${ROOT}/logs/build.log"

#==================================================
# Section 5.0 - Runtime Execution
#==================================================

echo "[INFO] Running lesson: $LESSON_PATH" | tee -a "$LOG_FILE"

FULL_PATH="${ROOT}/${LESSON_PATH}"

# Run the SolvraScript VM directly with the lesson path
set +e
"$SOLVRA_SCRIPT_BIN" "$FULL_PATH" 2>&1 | tee -a "$LOG_FILE"
status=${PIPESTATUS[0]}
set -e

if [ "$status" -eq 0 ]; then
  echo "[INFO] Lesson completed successfully." | tee -a "$LOG_FILE"
else
  echo "[ERROR] Lesson failed with exit code $status. See $LOG_FILE for details." | tee -a "$LOG_FILE"
  exit "$status"
fi



#--------------------------------------------------
# End comments: Demonstrates successful VM execution of base syntax
# @ZNOTE: Foundation for later runtime interaction lessons
#--------------------------------------------------

#==================================================
# End of file
#==================================================
