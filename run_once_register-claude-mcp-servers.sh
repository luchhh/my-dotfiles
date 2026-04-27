#!/bin/sh
# Register user-level Claude Code MCP servers.
# run_once_ means chezmoi runs this only when the script content changes.

claude mcp add linear --transport http https://mcp.linear.app/mcp --scope user 2>/dev/null || true
claude mcp add vercel --transport http https://mcp.vercel.com --scope user 2>/dev/null || true
