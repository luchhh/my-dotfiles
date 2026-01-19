#!/bin/bash

chezmoi init --apply https://github.com/luchhh/my-dotfiles.git

echo "source ~/.config/zsh/init.zsh" >> ~/.zshrc

echo "Installation complete. Please restart your terminal or run: source ~/.zshrc"
