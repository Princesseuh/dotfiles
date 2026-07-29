---
name: herd
description: Fan out GitHub issue triage across Herdr workspaces — one worktree + Claude agent per issue, dispatched and overseen from the current workspace. Use when invoked with a space-separated list of issue numbers or issue URLs.
argument-hint: <issue-number|issue-url> ...
---

# herd

You are the **overseer**. You live in a Herdr workspace checked out to the target repo. Stay put — never `cd` away or change your own workspace. For each issue in the arguments, spawn a worktree + workspace with its own Claude agent, dispatch a task prompt, then oversee.

## Preconditions

- Confirm you are inside Herdr: `test "${HERDR_ENV:-}" = 1`. If not, stop and tell the user this skill only works inside a Herdr workspace.
- Your own context is `$HERDR_WORKSPACE_ID` / `$HERDR_TAB_ID` / `$HERDR_PANE_ID`.
- Arguments are issue numbers or full issue URLs (extract the trailing number; URLs may point at the current repo only — `gh` uses the current repo).

## Per-issue pipeline

Run the steps below for EACH issue, parallelizing across issues where possible.

### 1. Fetch and classify

```sh
gh issue view <n> --json number,title,body,labels
```

Read the title and body. Classify to pick a branch prefix:

| Class | Prefix |
|---|---|
| bug | `fix/` |
| investigation / question | `investigate/` |
| feature | `feat/` |

Build a short kebab-case slug from the title. Branch name: `<prefix><n>-<slug>`.

### 2. Create the worktree (new workspace + tab + pane)

```sh
herdr worktree create --workspace "$HERDR_WORKSPACE_ID" \
  --branch "<prefix><n>-<slug>" --base main \
  --label "issue-<n>" --no-focus --json
```

Parse the JSON: pane id is `result.root_pane.pane_id`, tab id is `result.tab.tab_id`. **Never construct IDs — always read them from JSON.** They are opaque strings.

### 3. Launch Claude in the pane

```sh
herdr pane run <pane_id> "claude --permission-mode auto"
herdr wait agent-status <pane_id> --status idle --timeout 60000
```

Auto mode self-approves safe actions (reads, `gh` queries, builds) and only prompts for genuinely risky ones, so spawned agents rarely block.

### 4. Rename the tab

```sh
herdr tab rename <tab_id> "<n> · <short human summary of the issue>"
```

### 5. Dispatch the task prompt

```sh
herdr pane run <pane_id> "<prompt>"
```

The prompt must give full context:

- It is in a git worktree on branch `<prefix><n>-<slug>` of <repo>, with a one-line description of what the repo is.
- Tell it to run `gh issue view <n>` for the full report, and include your own 1–3 sentence summary of the issue.
- State the goal by class:
  - **bug / feature**: reproduce, root-cause, fix, add a regression test.
  - **investigation**: reproduce, research, write findings to a markdown doc in the worktree, and report back BEFORE implementing any fix.
- Tell it NOT to commit — leave all changes in the working tree; the user handles commits themselves.

## Oversee approvals

Agents run in auto mode, so most actions self-approve — but risky ones still block, and they surface as `blocked` panes.

- Poll each spawned pane: `herdr pane get <pane_id>` reports `agent_status`: `idle` | `working` | `blocked` | `done`.
- When a pane is `blocked`, read the prompt with `herdr pane read <pane_id> --source recent-unwrapped --lines 20`, then answer with `herdr pane send-keys <pane_id> 2` ("Yes, and don't ask again") for safe repeated commands, or `1` for one-off approvals. If auto mode flagged it, it's likely destructive or unusual — judge carefully; surface anything questionable to the user instead of approving.
- After dispatching all issues, report a summary table (issue, class, branch, tab name, pane id, status), then keep polling and approving. Don't narrate routine progress — report only when something interesting happens: an agent finishes, gets stuck, hits a permission prompt you won't auto-approve, or surfaces a finding worth knowing.

**Overseeing is automatic — never ask permission to watch.** After dispatching, immediately start a background watcher that polls the panes until they finish, and report back when they land. Do NOT end a turn asking "want me to watch and ping you when they're done?" or "should I keep polling?" — watching, polling, clearing approvals, and reporting results ARE the overseer's job. Just do it and say you're doing it. Ask the user only about genuine decisions (product/API choices, outward-facing actions), never about routine supervision. A working pattern (run in the background):

```sh
for i in $(seq 1 360); do   # 10s interval, ~1h timeout
  busy=0
  for p in $PANES; do
    herdr pane get "$p" | grep -qE '"agent_status": *"(idle|done)"' || busy=1
  done
  test $busy = 0 && break
  sleep 10
done
```

## Review a PR in an existing worktree

After an author agent has opened its PR, spin up a FRESH-CONTEXT reviewer beside it. Split a NEW pane inside that worktree's existing tab — do NOT start a new session in the author's pane; keep the author session intact side-by-side.

### 1. Split a sibling pane in the worktree tab

```sh
herdr pane split <author_pane_id> --direction right --no-focus --cwd <worktree_checkout_path>
```

- **GOTCHA — always pass `--cwd` with the worktree's checkout path explicitly.** `herdr pane split` can inherit a stray foreground cwd from the parent pane, landing the new pane in an unrelated directory — the reviewer would review the wrong repo. After splitting, verify with `herdr pane get <new_pane_id>` that `cwd` is the worktree before launching claude; if it's wrong, close the pane and re-split with `--cwd`.
- `herdr pane split` does NOT accept a `--json` flag (passing it errors and aborts the split). It already prints JSON by default — read the new pane id from `result.pane.pane_id`.

### 2. Label it

```sh
herdr pane rename <new_pane_id> "review-<n>"
```

### 3. Launch a fresh claude

```sh
herdr pane run <new_pane_id> "claude --permission-mode auto"
herdr wait agent-status <new_pane_id> --status idle --timeout 60000
```

### 4. Dispatch a review prompt

The reviewer is fresh, with no prior context. Tell it to: pull the PR for this branch via `gh pr view` + `gh pr diff`, read the linked issue, critically assess correctness, edge cases, regressions, test coverage, and comment/code cleanliness. READ-ONLY — do not push or edit. Report concise, honest findings.

### 5. Clear approvals

Auto mode handles routine approvals itself — poll for the occasional `blocked` prompt and clear it as in "Oversee approvals".

### Verifying CI

- Do NOT parse `gh pr checks <n>` with awk column indexes (`{print $1,$2}`) — check names contain spaces ("Rust benchmarks", "CodSpeed Performance Analysis"), so column-splitting silently misreads the status field and can report a FAILING check as passing. Read the raw output, or use `gh pr view <n> --json statusCheckRollup` and inspect `conclusion`.
- Distinguish infrastructure flakes from real failures before fixing anything. A benchmark job whose benchmarks all ran ("Measured") but whose results upload failed ("Request failed after 3 retries") is flaky infra — the fix is `gh run rerun <run-id> --failed`, not a code change. A CodSpeed check failing while the benchmark jobs themselves passed is the analysis flagging a genuine perf regression.

## Herdr rules

- Always pass `--no-focus` for background work — the user's focus must not move.
- Parse every ID from `--json` output; never derive IDs.
- Each worktree becomes its own workspace; the overseer workspace stays as the issue dashboard.
