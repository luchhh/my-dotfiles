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

3. Check what's ahead of the base branch:
   ```
   git merge-base HEAD origin/main   # or origin/master
   git log <merge-base>..HEAD --oneline
   ```
   If there are no commits ahead of the base at all — stop and tell the user there is nothing to ship.

4. Check for unpushed commits:
   ```
   git log origin/HEAD..HEAD --oneline
   ```
   If there are unpushed commits — show them to the user, then push:
   ```
   git push -u origin HEAD
   ```
   If everything is already pushed — skip the push and continue.

5. Invoke `/describe pr` to generate the PR title and description.

6. Check if a PR already exists for this branch:
   ```
   gh pr view --json title,url 2>/dev/null
   ```

7. If no PR exists — create one in draft:
   ```
   gh pr create --title "<title from step 5>" --body "<body from step 5>"
   ```

   If a PR already exists — update it:
   ```
   gh pr edit --title "<title from step 5>" --body "<body from step 5>"
   ```

8. Show the PR url.
