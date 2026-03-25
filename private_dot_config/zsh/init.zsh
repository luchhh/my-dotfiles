# Source all alias files
for alias_file in ~/.config/zsh/aliases/*.zsh; do
  source "$alias_file"
done

# Source core configurations
source ~/.config/zsh/lib/colors.zsh
function complete() {}  # no-op to suppress bash completion errors when sourcing git.zsh in zsh
source ~/.config/zsh/lib/git.zsh #needed for prompt
unfunction complete
source ~/.config/zsh/lib/prompt.zsh

# Optional tools
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
