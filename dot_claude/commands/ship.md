---
description: Commit unpushed changes and create or update the PR. Optionally creates a new branch first.
argument-hint: optional-branch-name
---

Ship the current work: commit any uncommitted changes, push all unpushed commits, then create or update the PR.

## Steps

1. Check the current branch:
   - If on `main` or `master` and `$ARGUMENTS` is empty — stop and tell the user to provide a branch name: `/ship <branch-name>`
   - If `$ARGUMENTS` is not empty — create and switch to that branch:
     ```
     git checkout -b $ARGUMENTS
     ```

2. If there are uncommitted changes, run `/commit` to stage and commit them first.

3. Check for unpushed commits:
   ```
   git log origin/HEAD..HEAD --oneline
   ```
   If there is nothing to push, stop and tell the user.

4. Show the list of unpushed commits so the user knows what is going out.

5. Push:
   ```
   git push -u origin HEAD
   ```

6. Generate a PR description from the full unpushed diff:
   ```
   git diff origin/HEAD~$N..origin/HEAD | ~/.claude/scripts/.venv/bin/python ~/.claude/scripts/diff_writer.py --format pr
   ```
   Where `$N` is the number of unpushed commits from step 3.

7. Check if a PR already exists for this branch:
   ```
   gh pr view --json title,url 2>/dev/null
   ```

8. If no PR exists — create one:
   ```
   gh pr create --title "<title from step 6>" --body "<body from step 6>"
   ```

   If a PR already exists — update it:
   ```
   gh pr edit --title "<title from step 6>" --body "<body from step 6>"
   ```

9. Show the PR url.
