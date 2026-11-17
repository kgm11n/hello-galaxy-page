#!/usr/bin/env bash
# Smoke check for the demo site: every page has a title, every local link and stylesheet exists, and nobody left the BREAK-CI marker in.
# Exit 0 = pass, 1 = fail. It is what the CI workflow runs; run it by hand from the site's root: bash tests/smoke.sh
cd "$(dirname "$0")/.." || exit 1
fail=0
for f in *.html; do
  grep -q '<title>[^<]\+</title>' "$f" || { echo "FAIL $f: no <title>"; fail=1; }
  grep -q 'BREAK-CI' "$f" && { echo "FAIL $f: contains the BREAK-CI marker"; fail=1; }
  for target in $(grep -oE '(href|src)="[^"#:]+"' "$f" | sed -E 's/^(href|src)="//; s/"$//'); do
    [ -e "$target" ] || { echo "FAIL $f: broken link to $target"; fail=1; }
  done
done
[ $fail -eq 0 ] && echo "ok: $(ls *.html | wc -l) pages" || exit 1
