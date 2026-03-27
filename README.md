# My Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Bootstrap (new machine)

The only manual step is installing Homebrew and chezmoi. Everything else is automated.

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install chezmoi
brew install chezmoi

# 3. Init and apply dotfiles
chezmoi init --apply https://github.com/luchhh/my-dotfiles.git
```

`chezmoi apply` will:
- Deploy all config files
- Run `brew bundle` to install all apps and tools from the Brewfile

**After applying**, hook up the zsh config (one-time, per machine):
```bash
echo 'source ~/.config/zsh/init.zsh' >> ~/.zshrc
```
This is needed because chezmoi doesn't manage `~/.zshrc` directly, so this line tells zsh where to load the config from.

**Set your git identity** (also one-time, not stored in the repo for privacy):
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Then restart your terminal or run `source ~/.zshrc`.

## What's Included

### zsh
- **Custom prompt**: Shows current directory and git branch with dirty indicator
- **Aliases**:
  - Navigation: `..`, `...`
  - Git shortcuts: `ga`, `gs`, `gc`, `gco`, `gd`, `gl`, `gpu`, etc.
- **Colors**: ANSI color variables for scripting
- **Path**: Homebrew integration for Apple Silicon
- **Optional**: fzf integration if installed

### tmux
- **Prefix**: `Ctrl+a` (instead of default `Ctrl-b`)
- **Mouse**: Enabled
- **Vi mode**: Copy mode uses vim keybindings
- **Pane splitting**: `prefix + v` (horizontal), `prefix + i` (vertical)
- **Pane navigation**: `Alt-h/j/k/l` with vim-tmux-navigator awareness
- **Theme**: Catppuccin color scheme
- **Other bindings**:
  - `prefix + Space` — Zoom pane
  - `prefix + t` — Choose session tree
  - `prefix + r` — Reload config
  - `prefix + b` — Break pane to new window

### inputrc
- Vi editing mode for readline-based applications
- `Ctrl-l` clears screen in both command and insert modes

### Claude Code
- Skills: `/commit`, `/ship`
- Global rules in `~/.claude/CLAUDE.md`
