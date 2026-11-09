#!/usr/bin/env bash
# Crown Defender read-only Mac build environment inspection.
# Usage: bash scripts/check_environment.sh
set -u
run() {
  printf '\n===== %s =====\n' "$1"
  shift
  if command -v "$1" >/dev/null 2>&1; then "$@" 2>&1 || true
  else printf 'Unavailable: %s\n' "$1"; fi
}
echo 'CROWN DEFENDER / DEVELOPMENT ENVIRONMENT (NO MUTATION)'
run 'macOS version' sw_vers
run 'CPU architecture' uname -m
run 'Xcode path' xcode-select -p
run 'Xcode version' xcodebuild -version
run 'Available SDKs' xcodebuild -showsdks
run 'Available simulator devices' xcrun simctl list devices available
run 'Git version' git --version
printf '\n===== GitHub auth availability =====\n'
if command -v gh >/dev/null 2>&1; then
  if gh auth status >/dev/null 2>&1; then printf 'GitHub CLI authenticated (details omitted)\n'
  else printf 'GitHub CLI installed but not authenticated\n'; fi
else printf 'GitHub CLI not installed\n'; fi
printf '\nNote: No real Apple Watch model/OS or actual build success can be inferred from this report.\n'
