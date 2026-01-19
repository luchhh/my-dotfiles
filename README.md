# My Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

### inputrc
- Vi editing mode for readline-based applications
- `Ctrl-l` clears screen in both command and insert modes

### tmux
- **Prefix**: `Alt-Space` (instead of default `Ctrl-b`)
- **Mouse**: Enabled
- **Vi mode**: Copy mode uses vim keybindings
- **Pane splitting**: `prefix + v` (horizontal), `prefix + i` (vertical)
- **Pane navigation**: `Alt-h/j/k/l` with vim-tmux-navigator awareness
- **Theme**: Catppuccin color scheme
- **Other bindings**:
  - `prefix + Space` - Zoom pane
  - `prefix + t` - Choose session tree
  - `prefix + r` - Reload config
  - `prefix + b` - Break pane to new window

### zsh
- **Custom prompt**: Shows current directory and git branch with dirty indicator
- **Aliases**:
  - Navigation: `..`, `...`
  - Tree fallback if not installed
  - Git shortcuts: `ga`, `gs`, `gc`, `gco`, `gd`, `gl`, `gpu`, etc.
- **Colors**: ANSI color variables for scripting
- **Path**: Homebrew integration for Apple Silicon
- **Optional**: fzf integration if installed

## Installation

### Prerequisites

Install [chezmoi](https://www.chezmoi.io/install/):
```bash
brew install chezmoi
```

### Fresh Install (from GitHub)

```bash
chezmoi init --apply https://github.com/luchhh/my-dotfiles.git
echo 'source ~/.config/zsh/init.zsh' >> ~/.zshrc
```

### From Local Clone

If you already have the repo cloned:
```bash
rm -rf ~/.local/share/chezmoi
ln -s /path/to/my-dotfiles ~/.local/share/chezmoi
chezmoi apply
echo 'source ~/.config/zsh/init.zsh' >> ~/.zshrc
```

### After Installation

Restart your terminal or run:
```bash
source ~/.zshrc
```
