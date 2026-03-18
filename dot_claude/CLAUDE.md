# Global Claude Rules

## chezmoi
Always use `chezmoi git` to interact with the chezmoi repo — never `cd ~/.local/share/chezmoi && git ...`.

```bash
chezmoi git -- add -A
chezmoi git -- commit -m "message"
chezmoi git -- push
```
