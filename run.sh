#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v salam >/dev/null 2>&1; then
  echo "ERROR: 'salam' was not found on PATH."
  echo "Install Salam from https://www.salamlang.ir/install and reopen your terminal."
  exit 1
fi

salam run main.salam -- episode1.mp4 \
  --intro-image images/start.png --intro-duration 3 \
  --outro-image images/end.png --outro-duration 3 \
  -o output.mp4
