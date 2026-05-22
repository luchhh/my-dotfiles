---
description: Generate and create Linear tickets in a project or as sub-issues of a parent. Usage: /create-tickets <url | description>
argument-hint: <url | description>
---

Create Linear tickets from a feature description or URL.

Usage: /create-tickets <url | plain text description>

## Steps

### 1. Generate the plan

Run the plan-tickets skill with $ARGUMENTS and display the full output.

### 2. Ask for confirmation

Ask: "Create these tickets in Linear? (yes/no)"

If the input was a Linear issue URL, also ask: "Create as sub-issues of that issue? (yes/no)"

Otherwise ask which team and project to create the issues in.

### 3. Create tickets in Linear

Using the available Linear MCP tools:

- Create tickets in topological order — no-dependency tickets first, then those that depend on them
- After all tickets are created, wire up "blocked by" relations using the actual Linear issue IDs
- If creating sub-issues, set each ticket's parent to the input Linear issue
- Print a summary with each ticket title and its Linear URL
