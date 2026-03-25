# Global Claude Rules

## chezmoi

Files under `~/.claude/` and `~/.config/` are managed by chezmoi — edit them via `~/.local/share/chezmoi/` instead of directly, then run `chezmoi apply` to deploy the changes.

To install a new package:
1. Update `~/.local/share/chezmoi/dot_Brewfile`
2. Run `brewup` (alias for `chezmoi apply && brew bundle --global`)
3. Commit and push

Use `chezmoi git` for all git operations on the dotfiles repo:

```bash
chezmoi git -- add -A
chezmoi git -- commit -m "message"
chezmoi git -- push
```
