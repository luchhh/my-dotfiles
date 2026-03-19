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

### Claude Code
- Skills: `/commit`, `/ship`
- Scripts and global rules in `~/.claude/`

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

Install [chezmoi](https://www.chezmoi.io/install/) and [asdf](https://asdf-vm.com/) (for Python and Node.js):
```bash
brew install chezmoi asdf
asdf plugin add python && asdf install python latest:3.12
asdf plugin add nodejs && asdf install nodejs latest:20
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

Run `install.sh` to install remaining dependencies (Claude Code, gh CLI):
```bash
bash ~/.local/share/chezmoi/install.sh
```

Then restart your terminal or run:
```bash
source ~/.zshrc
```
