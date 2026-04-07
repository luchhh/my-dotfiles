# Completion
autoload -Uz compinit && compinit

# ls colors
export CLICOLOR=1

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

# asdf shims
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Optional tools
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv hook (silent — set log_format in ~/.config/direnv/direnv.toml, empty string to see output)
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# Local secrets (not tracked by chezmoi)
[ -f ~/.config/secrets.sh ] && source ~/.config/secrets.sh
