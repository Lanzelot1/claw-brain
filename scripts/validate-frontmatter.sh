#!/usr/bin/env bash
set -euo pipefail

# Validate that all .md files in knowledge/ have source: frontmatter

found=0
errors=0

while IFS= read -r file; do
  found=$((found + 1))

  # Check file starts with ---
  if ! head -1 "$file" | grep -q '^---$'; then
    echo "FAIL: $file — missing YAML frontmatter"
    errors=$((errors + 1))
    continue
  fi

  # Extract frontmatter (between first and second ---)
  frontmatter=$(sed -n '1,/^---$/{ /^---$/d; p; }' "$file" | tail -n +1)

  # Check for source: field
  if ! echo "$frontmatter" | grep -q '^source:'; then
    echo "FAIL: $file — missing source: in frontmatter"
    errors=$((errors + 1))
  fi
done < <(find knowledge -name '*.md' -not -name '.gitkeep' 2>/dev/null)

if [[ $found -eq 0 ]]; then
  echo "No knowledge .md files found — skipping."
  exit 0
fi

echo ""
echo "Checked $found file(s), $errors error(s)."
[[ $errors -eq 0 ]]
