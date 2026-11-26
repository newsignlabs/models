#!/usr/bin/env bash
# fetch.sh OUT URL [URL...] — download OUT from the first URL that works.
set -euo pipefail
out="$1"; shift
for url in "$@"; do
  echo "trying $url"
  if curl -fL --retry 3 --retry-delay 5 -o "$out.tmp" "$url"; then
    mv "$out.tmp" "$out"; echo "got $out ($(stat -c %s "$out") bytes) from $url"; exit 0
  fi
done
echo "no working URL for $out" >&2; exit 1
