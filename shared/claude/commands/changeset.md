Review the current diff (staged + unstaged) or recent commits to understand what changed.

Check whether this project uses `@changesets/cli` (look for a `.changeset/` directory) or `.sampo` (look for a `.sampo` config/directory). Use whichever is present. If both exist, ask which to use.

For sampo projects, use the CLI to create the changeset:
```
sampo add --package <package1> --package <package2> --bump <patch|minor|major> -m "<description>"
```

Example:
```
sampo add --package cargo/satteri-mdxjs --package npm/satteri --bump patch -m "Fixed optimizeStatic silently collapsing elements that have runtime component overrides via \`export const components\`"
```

Write a changeset entry with:

1. **Semver bump**: Determine whether this is a `patch` (bug fix), `minor` (new feature), or `major` (breaking change) based on the changes. If unclear, ask.

2. **Description**: Describe the *result* the user gets, not the work that was done. Users don't care what was refactored, which function changed, or how the fix works internally — they care about what's different for them now. Ask: "if I were a user reading this in a changelog, what would I want to know?"

Rules:
- Lead with a past-tense verb describing the user-visible effect: "Fixed", "Added", "Removed", "Updated", "Improved", etc.
- No implementation details, file paths, function names, internal flags, or refactor talk.
- API surface that users call (public functions, options, CLI flags, config keys) *is* user-facing — name them directly.
- Internal symbols (private helpers, file names, the specific function that had the bug) are not — describe the behavior, not the code.
- For additions (new feature, option, etc.), add a short sentence on why it's useful — what it lets the user do or which problem it solves.
- Be precise and concise. One sentence is the default.

Code examples — only when the change adds, changes, or removes an API users write against (new/renamed option, changed signature, new config key, new CLI flag, breaking change):
- Add a short code block showing the *new* usage, so a user can copy it. Show the minimum needed to convey the change, not a full setup.
- For breaking changes, show before → after so users know how to migrate.
- For plain bug fixes with no API change, no code example — keep it to the one-sentence description.

Example with an API change — the entry is the sentence followed by a fenced code block:

> Added a `format` option to `exportCSV` for customizing date output.
>
> ```js
> exportCSV(rows, { format: { date: 'yyyy-MM-dd' } })
> ```

Example of a breaking change — show before → after so users can migrate:

> Renamed the `legacyMode` option to `compat`.
>
> ```diff
> - render({ legacyMode: true })
> + render({ compat: true })
> ```

Good (focus on what the user sees/gets):
- "Fixed dropdown menu closing unexpectedly when clicking disabled items"
- "Added support for custom date formats in CSV exports"
- "Removed deprecated `legacyMode` option"
- "Improved error messages with troubleshooting links"
- "Fixed components passed via `export const components` being silently dropped during static optimization"

Bad (describes the work, not the result):
- "Refactored the handleClick handler in DropdownMenu.tsx" → what changes for the user?
- "Bump deps" → so what?
- "Fix bug" → which one, and what was broken?
- "Updated optimizeStatic to check for runtime overrides before collapsing" → internal mechanics; say what the user was hitting instead.
