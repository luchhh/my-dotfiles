---
description: Commit staged and untracked changes with an AI-generated commit message.
---

Commit current changes with an AI-generated message.

## Steps

1. Run `git status` and `git diff` to show what has changed. If there is nothing to commit, stop and tell the user.

2. Generate a commit message by piping the diff to `diff_writer.py`:
   ```
   git diff | ~/.claude/scripts/.venv/bin/python ~/.claude/scripts/diff_writer.py --format commit
   ```

3. Show the generated commit message to the user and ask for confirmation before committing.

4. Commit with the confirmed message:
   ```
   git commit -m "<message>"
   ```

5. Show `git status` to confirm the working tree is clean.
