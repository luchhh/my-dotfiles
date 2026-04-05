#!/bin/bash
set -e

# Source secrets in case this runs outside an interactive shell (e.g. launchd)
[ -f "$HOME/.config/secrets.sh" ] && source "$HOME/.config/secrets.sh"

if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
  echo "Error: TELEGRAM_BOT_TOKEN is not set. Add it to ~/.config/secrets.sh"
  exit 1
fi

NEWS_FILE="$HOME/Documents/Claude/news_summary.txt"

if [ ! -f "$NEWS_FILE" ]; then
  echo "Error: $NEWS_FILE not found"
  exit 1
fi

curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d chat_id="1506428962" \
  --data-urlencode text@"$NEWS_FILE" \
  -d parse_mode=HTML
