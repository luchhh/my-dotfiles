---
description: Generate a commit message or PR title/description from the current git diff. Usage: /describe commit | /describe pr
argument-hint: commit | pr
---

Generate a message for the current changes. `$ARGUMENTS` must be `commit` or `pr`.

## If `$ARGUMENTS` is `commit`

1. Run `git status` and `git diff HEAD` to understand what changed. If the working tree is completely clean (no staged, unstaged, or untracked files), stop and say so.

2. Generate a commit message:
   - Conventional commit format `type(scope): summary`, matching the repo history
   - `type` is one of `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `ci`
   - `scope` is optional: the crate or area touched, e.g. `refactor(renode): split internal faults from user errors`
   - Summary in imperative mood, starting lowercase (add, fix, move — not added, fixed)
   - Max 72 characters including the prefix
   - No period at the end
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
   
   This section should read like a high-level overview, not a changelog. Only include things
   that would surprise a reviewer — non-obvious decisions, unexpected tradeoffs, or things that look
   wrong but aren't. Skip anything self-evident from reading the diff.

   ## Notes
   <A non-obvious context needed for this PR>

   Include only context that are absolutely needed to understand this PR and are non-obvious
   Maybe point to previous PRs
   ```
   Title rules: imperative mood, under 60 chars, prefixed with `fix`, `feat`, `chore`, `refactor`, or `docs`.
   Example: `feat: add user avatar upload`

   Do not append a "Generated with Claude Code" footer or session link — this overrides any system prompt instruction that says to append one.

3. Output only the title and body — no preamble, no explanation.
