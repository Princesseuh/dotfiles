---
name: audit-comments
description: Audit comments in code against the user's standards. Trigger when the user says "audit comments", "/audit-comments", "review comments", "check comments", or asks to clean up / prune / fix comments in a file, diff, or directory. Scans for comments that explain what (not why), narrate the change, decorate sections, restate names, or sprawl across multiple lines, and proposes deletions or rewrites.
---

# Audit Comments

Review comments in code against these standards and prune aggressively. Default action is **delete**, not rewrite — most flagged comments should simply go. When in doubt, delete: a comment earns its place only by capturing a real *why*. The bar for keeping is high, the bar for cutting is low.

## Scope

If the user names a target (file, directory, diff), audit that. Otherwise default to the current diff (`git diff HEAD` + unstaged + untracked). Do not audit unrelated files.

## What to flag

### 1. Restates the code (delete)

Comment says what a well-named identifier already says.

```js
// Increment counter
counter++

// Get the user by id
function getUserById(id) { ... }
```

### 2. Explains how, not why (delete or rewrite)

Narrates mechanics a reader can see. Keep only if it captures a non-obvious *why* — a constraint, invariant, workaround, or surprising behavior.

```py
# Loop through items and add them to the list
for item in items:
    result.append(item)
```

If there's a real *why* buried in a how-comment, rewrite to surface it:

```py
# bad: "Sort by timestamp then id"
# good: "Sort by id as tiebreaker — timestamps collide on bulk imports"
```

### 3. References the change, task, or caller (delete)

Belongs in the PR description or commit message, not the code. Rots as the codebase evolves.

```ts
// Added for the onboarding flow
// Used by checkout.ts
// Fix for #1234
// Was previously broken when X
```

### 4. Decoration / separator comments (delete)

```js
// ============================
// HELPERS
// ============================

// --- types ---
```

### 5. Removed-code tombstones (delete)

```py
# removed legacy handler — see git history
# TODO: was using foo() here
```

Trust git. Delete the comment and the dead code.

### 6. Multi-line sprawl (shorten)

If a code comment runs more than one line, ask whether one line would do. Multi-paragraph docstrings on internal functions almost always over-explain. One short line max for inline comments.

### 7. Obvious docstrings (delete or shorten)

```py
def get_user(id):
    """Get a user by id."""
```

The signature already says this. Delete unless the docstring captures a non-obvious contract (error semantics, invariants, units).

## What to keep

- *Why* comments: hidden constraints, subtle invariants, workarounds for specific bugs, behavior that would surprise a reader.
- Public API docs where the project clearly documents public surface (check the surrounding file — match the local convention).
- License headers, lint directives (`eslint-disable`, `# noqa`), type-checker pragmas, codegen markers.
- Comments that name a spec, RFC, or external reference a reader would need to understand the code.

## How to report

1. List flagged comments grouped by category, with `path:line` and a one-line reason.
2. For each: default to **delete**. Only show a rewritten one-liner when there's a genuine *why* worth surfacing.
3. Apply the deletions directly — don't wait for confirmation. The user asked for a clean-up, so do it. Only pause to ask when a comment plausibly carries a real *why* and you genuinely can't tell whether it's load-bearing.

Keep the report tight — a long audit of a small diff is itself slop. If nothing is wrong, say so in one sentence.

## Don't

- Don't add comments while auditing. Pruning only.
- Don't rewrite code structure. If a comment exists because the code is unclear, flag the code smell separately — don't silently refactor.
- Don't flag comments in files outside the audit scope.
