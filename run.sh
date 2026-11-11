#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
salam run main.salam -- episode1.mp4 \
  --intro-image images/start.png --intro-duration 3 \
  --outro-image images/end.png --outro-duration 3 \
  -o output.mp4
