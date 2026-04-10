alias brewup="chezmoi apply && brew bundle --global"  # Deploy Brewfile and install packages

alias ll='ls -lah'       # Long list with hidden files, human-readable sizes
alias la='ls -A'         # List all except . and ..

alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories

# Repo intelligence when joining a new project
gitdive() {
  case "$1" in
    changes)  git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20 ;;
    authors)  git shortlog -sn --no-merges ;;
    bugs)     git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20 ;;
    fires)    git log --oneline --since="1 year ago" | grep -iE 'revert|hotfix|emergency|rollback' ;;
    momentum) git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c ;;
    *)        echo "Usage: gitdive <command>"
              echo ""
              echo "  changes   What files change the most"
              echo "  authors   Who built this"
              echo "  bugs      Where do bugs cluster"
              echo "  fires     How often is the team firefighting"
              echo "  momentum  Is this project accelerating or dying"
              ;;
  esac
}

# Tree
if [ ! -x "$(which tree)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi
