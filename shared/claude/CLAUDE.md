# Git commits

- Committing and pushing on a non-default branch is fine without asking, as long as the message follows the rules below.
- Committing or pushing to the default branch (`main`, `master`) needs my explicit approval every time — never on your own initiative, and never as a step inside a larger task I approved.
- Never run publish commands (npm/pnpm/yarn publish). Those stay off-limits unless explicitly asked
- Always use Conventional Commits, whatever the repository's own history looks like: `type(area): short summary`, e.g. `feat(parser): add inline footnote support`.
- Subject line only — no body or description unless I explicitly ask for one.
- Never add Claude or Anthropic attribution to commit messages or PR bodies — no `Claude-Session` trailer or session URL, no `Co-Authored-By: Claude` line, no "Generated with Claude Code" text. Commits contain only my own content.

# Git worktrees

- When running inside herdr (`HERDR_ENV=1`), create worktrees with `herdr worktree create`, and adopt an existing checkout with `herdr worktree open --cwd <source-repo> --path <checkout>`. Never `git worktree add` followed by `herdr workspace create --cwd`.
- Both routes put the files in the same place, so this is not about the path. Only the `herdr worktree` commands attach the metadata that groups the workspace under its source repo in the sidebar; a workspace made the other way shows up as a standalone space with no link back to the repo.
- `herdr worktree open` is safe on a checkout that already has a workspace: it returns `already_open: true` and attaches the missing metadata in place, keeping the pane and any running agent alive. Use it to repair a workspace instead of closing and recreating one.

# Privilege escalation

Never attempt `sudo`, `doas`, or any other privilege-escalation command. You can't supply a password, and repeated failed attempts lock me out of my own system. If a task genuinely needs root, stop and tell me the exact command to run myself.

# Comments

Default to no comment — expressive names and clear logic carry the load. Write one only for a *why* the code can't show (a constraint, workaround, or surprising behavior), and cap it at one line. If the why won't fit one line, that's a signal to fix the *code* — a clearer name, a helper, a test name — not to spill into a longer comment or reach for an issue link. Your understanding lives in your head and the PR, not the comment; a found *why* is not a license to explain it in full. Before finishing any edit, reread the comments you added and cut every one that isn't a load-bearing *why* — do this as a reflex, not only when a check flags it.

Never comment to restate code, narrate how it works, mark sections (`// === helpers ===`), tombstone removed code, or note why a change was made (`// fix for #1234`). These rules override the surrounding file's comment style; don't copy local slop. Exceptions that stay: license headers, lint/type pragmas (`eslint-disable`, `# noqa`), codegen markers, spec/RFC references, and a project's documented public-API surface.

Whatever does survive — comments and documentation alike — must explain current behavior, contracts, invariants, or rationale. It must never narrate change history ("now uses X", "previously returned null") or address a reviewer ("note that I kept this", "as discussed"). Write for someone meeting the code for the first time, with no memory of the diff that produced it.

# Changesets

- Keep changeset descriptions short and user-facing: describe the user-visible effect — what is fixed or added from a user's perspective — not the internal implementation, mechanism, or technical details.
- Prefer a single concise sentence, phrased plainly as a `Fixes ...` / `Adds ...` statement. Avoid long multi-sentence explanations of the underlying cause or how it works.
- Too long / too technical: "Fixed position offsets and columns for documents with multibyte unicode characters. Node positions reported byte offsets, so slicing drifted right whenever multibyte characters preceded a node. Offsets now count UTF-16 code units so they match remark, including emoji."
- Good: "Fixed position offsets being wrong in documents with multibyte characters."
- When asked about changesets, also check for `.sampo` configuration/files in the project.

# Pull requests

- When opening a PR for an issue, the body is just `Fixes #<number>` and nothing else, unless I say otherwise.

# GitHub issues and outward actions

- Never create GitHub issues unless I explicitly ask. This applies to subagents acting on your behalf too — don't delegate issue creation to them either.
- If you find something worth tracking (a bug, a gap, a follow-up), surface it to me in the conversation and let me decide whether it becomes an issue. (An agent once opened an issue that duplicated a divergence already documented in the repo's docs — surfacing it in chat first would have caught that.)
- More generally, don't take outward-facing actions on my repos — opening issues, posting comments — on your own initiative; ask first.

# Shell commands

Avoid shell constructs that trigger Bash security checks: no `for`/`while` loops, no `$()` subshells, no brace+quote expansion in Bash commands. Use `find`/`fd` + `xargs`, `grep -r`, or multiple simpler commands instead.
