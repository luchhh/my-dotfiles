#!/bin/bash
set -e

# ── asdf ────────────────────────────────────────────────────────
if ! command -v asdf &>/dev/null; then
    echo "Installing asdf..."
    if command -v brew &>/dev/null; then
        brew install asdf
        source "$(brew --prefix asdf)/libexec/asdf.sh"
    else
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
        source ~/.asdf/asdf.sh
    fi
else
    # Make sure asdf is sourced for this script
    if command -v brew &>/dev/null && [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
        source "$(brew --prefix asdf)/libexec/asdf.sh"
    elif [ -f ~/.asdf/asdf.sh ]; then
        source ~/.asdf/asdf.sh
    fi
fi

# ── Python ──────────────────────────────────────────────────────
if ! asdf plugin list | grep -q python; then
    asdf plugin add python
fi
PYTHON_VERSION=$(asdf latest python 3.12)
if ! asdf list python | grep -q "$PYTHON_VERSION"; then
    echo "Installing Python $PYTHON_VERSION..."
    asdf install python "$PYTHON_VERSION"
fi
asdf global python "$PYTHON_VERSION"

# ── Node.js ─────────────────────────────────────────────────────
if ! asdf plugin list | grep -q nodejs; then
    asdf plugin add nodejs
fi
NODE_VERSION=$(asdf latest nodejs 20)
if ! asdf list nodejs | grep -q "$NODE_VERSION"; then
    echo "Installing Node.js $NODE_VERSION..."
    asdf install nodejs "$NODE_VERSION"
fi
asdf global nodejs "$NODE_VERSION"

# ── Claude Code ─────────────────────────────────────────────────
if ! command -v claude &>/dev/null; then
    echo "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
fi

# ── gh CLI ──────────────────────────────────────────────────────
if ! command -v gh &>/dev/null; then
    echo "Installing gh CLI..."
    if command -v brew &>/dev/null; then
        brew install gh
    else
        echo "brew not found — install gh CLI manually: https://cli.github.com/" >&2
    fi
fi

echo "Installation complete."
