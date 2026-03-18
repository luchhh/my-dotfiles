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

# Source asdf so its managed Python is on PATH
if command -v brew &>/dev/null && [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
elif [ -f ~/.asdf/asdf.sh ]; then
    source ~/.asdf/asdf.sh
fi

# Find Python 3.10+
if command -v python3 &>/dev/null && python3 -c "import sys; sys.exit(0 if sys.version_info >= (3,10) else 1)"; then
    PYTHON="python3"
else
    echo "[chezmoi] ERROR: Python 3.10+ not found. Run install.sh first." >&2
    exit 1
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
