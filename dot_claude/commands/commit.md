---
description: Commit staged and untracked changes with an AI-generated commit message.
---

Commit current changes with an AI-generated message.

## Steps

1. Run `git status` to see what has changed. If there is nothing to commit, stop and tell the user.

2. Invoke `/describe commit` to generate the commit message.

3. Show the generated commit message to the user and ask for confirmation before committing.

4. Stage and commit with the confirmed message:
   ```
   git add -A
   git commit -m "<message>"
   ```

5. Show `git status` to confirm the working tree is clean.
