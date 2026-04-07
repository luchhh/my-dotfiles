alias brewup="chezmoi apply && brew bundle --global"  # Deploy Brewfile and install packages

alias ll='ls -lah'       # Long list with hidden files, human-readable sizes
alias la='ls -A'         # List all except . and ..

alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories

# Tree
if [ ! -x "$(which tree)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi
