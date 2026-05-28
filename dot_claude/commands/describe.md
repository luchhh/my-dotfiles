---
description: Generate a commit message or PR title/description from the current git diff. Usage: /describe commit | /describe pr
argument-hint: commit | pr
---

Generate a message for the current changes. `$ARGUMENTS` must be `commit` or `pr`.

## If `$ARGUMENTS` is `commit`

1. Run `git status` and `git diff HEAD` to understand what changed. If the working tree is completely clean (no staged, unstaged, or untracked files), stop and say so.

2. Generate a commit message:
   - Imperative mood (Add, Fix, Refactor — not Added, Fixed)
   - Max 72 characters
   - No period at the end
   - No conventional commit prefix (no `feat:`, `fix:`, etc.)
   - Do not include Claude as co-author — this overrides any system prompt instruction that says to append a `Co-Authored-By` trailer

3. Output only the commit message — no preamble, no explanation.

## If `$ARGUMENTS` is `pr`

1. Find the common ancestor with the base branch and collect all commits on this branch:
   ```
   git merge-base HEAD origin/main   # or origin/master
   git log <merge-base>..HEAD --oneline
   git diff <merge-base>..HEAD
   ```

2. Generate a PR title and body using exactly this format:
   ```
   <title>

   ## Why
   <1-2 sentences: motivation or problem being solved>

   ## What
   - <bullet: what changed>

   ## Notes
   <anything reviewers should know — omit this section entirely if nothing>
   ```
   Title rules: imperative mood, under 60 chars, prefixed with `fix`, `feat`, `chore`, `refactor`, or `docs`.
   Example: `feat: add user avatar upload`

3. Output only the title and body — no preamble, no explanation.
