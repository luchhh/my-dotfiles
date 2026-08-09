#!/bin/sh
# Install and register the Onshape MCP server (local stdio).
# run_onchange_ means chezmoi re-runs this whenever the script content changes.
#
# Unlike the remote HTTP servers in run_once_register-claude-mcp-servers.sh,
# Onshape has no hosted MCP endpoint, so it has to be cloned and built locally.
#
# Credentials are NOT handled here. Create a read-only API key
# (My account -> Developer -> API keys, scope "read your documents" only)
# and put it in $DEST/.env. That file is gitignored and never enters chezmoi.

set -eu

DEST="$HOME/.local/share/onshape-mcp"
REPO="https://github.com/hedless/onshape-mcp.git"
# Pinned to a known-good commit; upstream is a stale community project and
# tracking develop risks silent breakage. Bump deliberately after testing.
COMMIT="54d21cc"

# --- locate a Python >= 3.10 ---------------------------------------------
PY=""
for c in \
  "$HOME/.asdf/installs/python/3.12.13/bin/python3" \
  "$(command -v python3.12 2>/dev/null || true)" \
  "$(command -v python3.11 2>/dev/null || true)" \
  "$(command -v python3 2>/dev/null || true)"
do
  [ -n "$c" ] && [ -x "$c" ] || continue
  if "$c" -c 'import sys; sys.exit(0 if sys.version_info >= (3,10) else 1)' 2>/dev/null; then
    PY="$c"; break
  fi
done

if [ -z "$PY" ]; then
  echo "onshape-mcp: no Python >= 3.10 found; skipping install." >&2
  exit 0
fi

# --- clone (idempotent) ---------------------------------------------------
if [ ! -d "$DEST/.git" ]; then
  echo "onshape-mcp: cloning into $DEST"
  git clone --quiet "$REPO" "$DEST"
fi
git -C "$DEST" fetch --quiet origin
git -C "$DEST" checkout --quiet "$COMMIT"

# --- venv + deps ----------------------------------------------------------
[ -d "$DEST/venv" ] || "$PY" -m venv "$DEST/venv"
"$DEST/venv/bin/pip" install --quiet --upgrade pip
"$DEST/venv/bin/pip" install --quiet -e "$DEST"
# Upstream declares an unbounded "mcp>=0.1.0". SDK 2.x removed the
# Server.list_tools/call_tool decorators this code is built on, so a fresh
# install resolves to a broken version. Force 1.x after the editable install.
"$DEST/venv/bin/pip" install --quiet "mcp<2"

# --- register with Claude Code -------------------------------------------
claude mcp add onshape --scope user -- "$DEST/venv/bin/python" -m onshape_mcp.server 2>/dev/null || true

# --- remind about credentials --------------------------------------------
if [ ! -f "$DEST/.env" ]; then
  echo "onshape-mcp: installed, but $DEST/.env is missing."
  echo "  Add ONSHAPE_ACCESS_KEY and ONSHAPE_SECRET_KEY to enable it."
fi
