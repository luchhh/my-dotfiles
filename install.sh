#!/bin/bash

# Install Claude Code if not present
if ! command -v claude &>/dev/null; then
    if ! command -v npm &>/dev/null; then
        echo "npm not found — install Node.js first: https://nodejs.org/" >&2
    else
        echo "Installing Claude Code..."
        npm install -g @anthropic-ai/claude-code
    fi
fi

# Install gh CLI if not present
if ! command -v gh &>/dev/null; then
    echo "Installing gh CLI..."
    if command -v brew &>/dev/null; then
        brew install gh
    else
        echo "brew not found — install gh CLI manually: https://cli.github.com/"
    fi
fi

chezmoi init --apply https://github.com/luchhh/my-dotfiles.git

echo "source ~/.config/zsh/init.zsh" >> ~/.zshrc

echo "Installation complete. Please restart your terminal or run: source ~/.zshrc"
