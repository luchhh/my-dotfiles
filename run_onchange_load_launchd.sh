#!/bin/bash
PLIST="$HOME/Library/LaunchAgents/com.user.send_news_summary.plist"

launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"
echo "✓ Loaded launchd job: com.user.send_news_summary"
