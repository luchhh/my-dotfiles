#!/bin/bash
# List of required tokens — add new ones here to be reminded on next `chezmoi apply`
required_tokens=(
  "TELEGRAM_BOT_TOKEN"
)

missing=()
for token in "${required_tokens[@]}"; do
  if ! grep -q "export ${token}" ~/.config/secrets.sh 2>/dev/null; then
    missing+=("$token")
  fi
done

if [ ${#missing[@]} -gt 0 ]; then
  echo ""
  echo "⚠️  Missing secrets in ~/.config/secrets.sh — add the following exports:"
  for token in "${missing[@]}"; do
    echo "    export ${token}=\"your_value_here\""
  done
  echo ""
fi
