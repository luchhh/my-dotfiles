#!/usr/bin/env python3
"""
diff_writer.py
--------------
Analyzes a git diff and generates either a commit message or a PR description.

Usage:
    diff_writer.py --format commit   → single-line commit message
    diff_writer.py --format pr       → structured PR description (markdown)

The diff is read from stdin:
    git diff | diff_writer.py --format commit
    git diff origin/HEAD..HEAD | diff_writer.py --format pr
"""

import sys
import argparse
import anthropic

MODEL = "claude-opus-4-6"
MAX_DIFF_CHARS = 8000


def read_diff() -> str:
    diff = sys.stdin.read().strip()
    if len(diff) > MAX_DIFF_CHARS:
        diff = diff[:MAX_DIFF_CHARS] + "\n\n[... diff truncated ...]"
    return diff


def context_agent(client: anthropic.Anthropic, diff: str) -> str:
    """Understands what changed and why — shared by both output formats."""
    response = client.messages.create(
        model=MODEL,
        max_tokens=512,
        system=(
            "You are a code analyst. Given a git diff, explain concisely:\n"
            "1. What files/areas changed and what type of change it is "
            "(feature, fix, refactor, config, docs, etc.)\n"
            "2. The likely motivation behind the change\n"
            "3. Any notable side effects or risks\n"
            "Be brief — this output feeds into another agent."
        ),
        messages=[{"role": "user", "content": f"Analyze this diff:\n\n```diff\n{diff}\n```"}],
    )
    return response.content[0].text


def commit_writer(client: anthropic.Anthropic, context: str) -> str:
    """Generates a single-line commit message."""
    response = client.messages.create(
        model=MODEL,
        max_tokens=100,
        system=(
            "You are a git commit message writer. "
            "Write a single commit message line following these rules:\n"
            "- Imperative mood (Add, Fix, Refactor — not Added, Fixed)\n"
            "- Max 72 characters\n"
            "- No period at the end\n"
            "- No conventional commit prefix (no 'feat:', 'fix:', etc.)\n"
            "Output ONLY the commit message, nothing else."
        ),
        messages=[{"role": "user", "content": f"Write a commit message for this change:\n\n{context}"}],
    )
    return response.content[0].text.strip()


def pr_writer(client: anthropic.Anthropic, context: str) -> str:
    """Generates a structured PR description in markdown."""
    response = client.messages.create(
        model=MODEL,
        max_tokens=1024,
        system=(
            "You are a senior engineer writing a pull request description. "
            "Given context about code changes, write a PR description using "
            "exactly this format:\n\n"
            "**{imperative title under 60 chars}**\n\n"
            "## What\n"
            "- (bullet: what changed)\n\n"
            "## Why\n"
            "(1-2 sentences: motivation)\n\n"
            "## Test plan\n"
            "- [ ] (specific thing to verify)\n\n"
            "## Notes\n"
            "(anything reviewers should know, or remove this section if nothing)\n\n"
            "Output ONLY the markdown, nothing else."
        ),
        messages=[{"role": "user", "content": f"Write a PR description for this change:\n\n{context}"}],
    )
    return response.content[0].text.strip()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--format",
        choices=["commit", "pr"],
        required=True,
        help="Output format: 'commit' for a commit message, 'pr' for a PR description",
    )
    args = parser.parse_args()

    diff = read_diff()
    if not diff:
        print("No diff provided.", file=sys.stderr)
        sys.exit(1)

    client = anthropic.Anthropic()

    # Shared step: understand the diff
    context = context_agent(client, diff)

    # Format-specific step
    if args.format == "commit":
        print(commit_writer(client, context))
    else:
        print(pr_writer(client, context))


if __name__ == "__main__":
    main()
