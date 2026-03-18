# Source all alias files
for alias_file in ~/.config/zsh/aliases/*.zsh; do
  source "$alias_file"
done

# Source core configurations
source ~/.config/zsh/lib/colors.zsh
source ~/.config/zsh/lib/git.zsh #needed for prompt
source ~/.config/zsh/lib/prompt.zsh

# Optional tools
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# asdf version manager
if command -v brew &>/dev/null && [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
elif [ -f ~/.asdf/asdf.sh ]; then
    source ~/.asdf/asdf.sh
fi
