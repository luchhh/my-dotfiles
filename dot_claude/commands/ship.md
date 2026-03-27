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

6. Get the full diff of what was just pushed:
   ```
   git diff origin/HEAD~$N..origin/HEAD
   ```
   Where `$N` is the number of unpushed commits from step 3.

7. Based on the diff, generate a PR description directly using exactly this format:
   ```
   **{imperative title under 60 chars}**

   ## What
   - (bullet: what changed)

   ## Why
   (1-2 sentences: motivation)

   ## Test plan
   - [ ] (specific thing to verify)

   ## Notes
   (anything reviewers should know, or remove this section if nothing)
   ```

8. Check if a PR already exists for this branch:
   ```
   gh pr view --json title,url 2>/dev/null
   ```

9. If no PR exists — create one:
   ```
   gh pr create --title "<title from step 7>" --body "<body from step 7>"
   ```

   If a PR already exists — update it:
   ```
   gh pr edit --title "<title from step 7>" --body "<body from step 7>"
   ```

10. Show the PR url.
