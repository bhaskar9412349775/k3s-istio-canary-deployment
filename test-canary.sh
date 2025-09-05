#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://localhost:8088}"
N="${2:-50}"

echo "Hitting $URL $N times..."
v1=0
v2=0
other=0

for i in $(seq 1 "$N"); do
  resp=$(curl -s "$URL" || true)
  if [[ "$resp" == *"v1"* ]]; then
    v1=$((v1+1))
  elif [[ "$resp" == *"v2"* ]]; then
    v2=$((v2+1))
  else
    other=$((other+1))
  fi
done

echo "Results:"
echo "  v1: $v1"
echo "  v2: $v2"
echo "  other: $other"
