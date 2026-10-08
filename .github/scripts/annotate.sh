#!/usr/bin/env bash
set -euo pipefail

level="$1"
title="$2"
file="$3"

if [ ! -s "$file" ]; then
  exit 0
fi

content="$(tail -c 60000 "$file" | tr -d '\r' | sed -e 's/%/%25/g' | awk 'BEGIN { ORS = "%0A" } { print }')"

echo "::${level} title=${title}::${content}"
