# Git commits

- Never add Claude or Anthropic attribution to commit messages or PR bodies — no `Claude-Session` trailer or session URL, no `Co-Authored-By: Claude` line, no "Generated with Claude Code" text. Commits contain only my own content: the subject line, plus a body only when I ask.
- Match the repository's existing commit-message convention — infer the style from recent `git log` (e.g. Conventional Commits like `fix(scope): ...` if that's what the repo uses).
- Subject line only by default — no body/description unless I explicitly ask for one.

# Changesets

- Keep changeset descriptions short and user-facing: describe the user-visible effect — what is fixed or added from a user's perspective — not the internal implementation, mechanism, or technical details.
- Prefer a single concise sentence, phrased plainly as a `Fixes ...` / `Adds ...` statement. Avoid long multi-sentence explanations of the underlying cause or how it works.
- Too long / too technical: "Fixed position offsets and columns for documents with multibyte unicode characters. Node positions reported byte offsets, so slicing drifted right whenever multibyte characters preceded a node. Offsets now count UTF-16 code units so they match remark, including emoji."
- Good: "Fixed position offsets being wrong in documents with multibyte characters."

# Pull requests

- When opening a PR for an issue, the body is just `Fixes #<number>` and nothing else, unless I say otherwise.

# GitHub issues and outward actions

- Never create GitHub issues unless I explicitly ask. This applies to subagents acting on your behalf too — don't delegate issue creation to them either.
- If you find something worth tracking (a bug, a gap, a follow-up), surface it to me in the conversation and let me decide whether it becomes an issue. (An agent once opened an issue that duplicated a divergence already documented in the repo's docs — surfacing it in chat first would have caught that.)
- More generally, don't take outward-facing actions on my repos — opening issues, posting comments — on your own initiative; ask first.
