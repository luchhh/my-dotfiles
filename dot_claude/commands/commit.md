---
description: Commit staged and untracked changes with an AI-generated commit message.
---

Commit current changes with an AI-generated message.

## Steps

1. Run `git status` and `git diff HEAD` to see what has changed. If there is nothing to commit, stop and tell the user.

2. Based on the diff, generate a commit message directly:
   - Imperative mood (Add, Fix, Refactor — not Added, Fixed)
   - Max 72 characters
   - No period at the end
   - No conventional commit prefix (no 'feat:', 'fix:', etc.)

3. Show the generated commit message to the user and ask for confirmation before committing.

4. Stage and commit with the confirmed message:
   ```
   git add -A
   git commit -m "<message>"
   ```

5. Show `git status` to confirm the working tree is clean.
