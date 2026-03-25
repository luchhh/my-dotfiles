#!/usr/bin/env bash
# run_once_setup-claude-scripts.sh
# ---------------------------------
# Chezmoi runs this automatically once per machine after `chezmoi apply`.
# Creates the venv used by ~/.claude/scripts/ tools (diff_writer.py, etc.)

set -e

SCRIPTS_DIR="$HOME/.claude/scripts"
VENV_DIR="$SCRIPTS_DIR/.venv"
REQUIREMENTS="$SCRIPTS_DIR/requirements.txt"

echo "[chezmoi] Setting up ~/.claude/scripts venv..."

# Find python3.11+ — prefer explicit versions, fall back to python3
if command -v python3.11 &>/dev/null; then
    PYTHON="python3.11"
elif command -v python3.12 &>/dev/null; then
    PYTHON="python3.12"
elif command -v python3 &>/dev/null; then
    PYTHON="python3"
else
    echo "[chezmoi] WARNING: Python 3.10+ not found. Skipping venv setup." >&2
    echo "[chezmoi] After installing Python via asdf, run: bash ~/.local/share/chezmoi/run_once_setup-claude-scripts.sh" >&2
    exit 0
fi

echo "[chezmoi] Using $($PYTHON --version)"

# Create venv if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    "$PYTHON" -m venv "$VENV_DIR"
    echo "[chezmoi] Venv created at $VENV_DIR"
fi

# Install/upgrade dependencies
"$VENV_DIR/bin/pip" install --quiet --upgrade pip
"$VENV_DIR/bin/pip" install --quiet -r "$REQUIREMENTS"

echo "[chezmoi] Done. ~/.claude/scripts is ready."
