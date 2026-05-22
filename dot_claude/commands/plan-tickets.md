Generate a list of Linear tickets from a feature description or URL.

Usage: /plan-tickets <url | plain text description>

## Input

$ARGUMENTS can be:
- A URL (Notion page, Linear issue, GitHub PR, Google Doc, or any webpage) → fetch its content
- Plain text → use as-is

## Steps

### 1. Fetch content if URL

If $ARGUMENTS looks like a URL, fetch its content using available tools (Notion MCP, Linear MCP, or WebFetch). Extract requirements, decisions already made, constraints, and open questions.

### 2. Generate tickets

Apply these rules:

- **Points (Fibonacci)**: 0.5, 1, 2, 3, 5, 8, 13
  - Never assign 13 — it signals danger for a sprint
  - Avoid 8 when possible; if you assign 8, mark uncertainty as High
  - Don't over-granularize into many 1s; find balance between task count and complexity
- **Incremental rollout**: prefer tickets that deliver value progressively
- **Testing included**: every ticket implicitly includes writing tests — do NOT create separate test tickets unless the ticket is specifically about test infrastructure (e.g. setting up Vitest or Playwright)
- **Spikes first**: if a ticket has significant uncertainty, precede it with a spike ticket whose output is a written decision or proof-of-concept
- **Dependencies explicit**: every ticket lists which others must be completed first

### 3. Output format

For each ticket:

```
N. Title

Description: 2–4 sentences. What needs to be done, why, and any key constraints. For spikes, state the expected output clearly.
Dependencies: list ticket titles, or "none"
Uncertainty: Low | Medium | High  ← omit this line if Low
Points: N
```

Then a summary at the end:

```
---
Summary
Tasks: N
Total points: N
Medium uncertainty: N
High uncertainty: N  ← includes any task with 8 points
```
