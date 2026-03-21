#!/usr/bin/env bash
set -euo pipefail

# Find all *.schema.json files and validate corresponding *.json files
found=0
errors=0

while IFS= read -r schema; do
  data="${schema%.schema.json}.json"
  if [[ -f "$data" ]]; then
    found=$((found + 1))
    echo "Validating $(basename "$data") against $(basename "$schema")..."
    if ! check-jsonschema --schemafile "$schema" "$data"; then
      errors=$((errors + 1))
    fi
  fi
done < <(find . -name '*.schema.json' -not -path './.git/*')

if [[ $found -eq 0 ]]; then
  echo "No schema/data pairs found — skipping."
  exit 0
fi

echo ""
echo "Validated $found file(s), $errors error(s)."
[[ $errors -eq 0 ]]
