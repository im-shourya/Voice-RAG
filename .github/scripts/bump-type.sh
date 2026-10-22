#!/usr/bin/env bash
# Reads one Conventional Commit message (subject + body) on stdin.
# Prints the SemVer bump that it needs: major | minor | patch | none.
#
#   type!: ...  or  "BREAKING CHANGE:" in the body  -> major
#   feat: ...                                       -> minor
#   fix: / perf: / refactor: / revert: ...           -> patch
#   docs: / test: / chore: / ci: / build: / style:  -> none
set -euo pipefail

msg="$(cat)"
subject="$(printf '%s\n' "$msg" | head -n 1)"

if printf '%s\n' "$subject" | grep -qE '^[a-z]+(\([^)]*\))?!:' \
  || printf '%s\n' "$msg" | grep -qE '^BREAKING[ -]CHANGE:'; then
  echo major
elif printf '%s\n' "$subject" | grep -qE '^feat(\([^)]*\))?:'; then
  echo minor
elif printf '%s\n' "$subject" | grep -qE '^(fix|perf|refactor|revert)(\([^)]*\))?:'; then
  echo patch
else
  echo none
fi
