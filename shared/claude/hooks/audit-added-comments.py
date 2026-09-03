#!/usr/bin/env python3
import json
import os
import re
import sys

HASH = {"py", "rb", "sh", "bash", "zsh", "fish", "pl", "pm", "r", "ex", "exs", "jl", "nu"}
SLASH = {"js", "jsx", "ts", "tsx", "mjs", "cjs", "c", "h", "cc", "cpp", "hpp", "cxx",
         "hxx", "java", "kt", "kts", "swift", "go", "rs", "php", "scala", "cs", "dart",
         "zig", "proto", "glsl"}
DASH = {"lua", "sql", "hs", "elm"}
SEMI = {"el", "clj", "cljs", "cljc", "scm"}

ALLOW = re.compile(
    r"(eslint-|prettier-ignore|@ts-|ts-expect-error|ts-ignore|type:\s*ignore|noqa|"
    r"pylint:|pyright:|mypy:|ruff:|biome-ignore|stylelint-|oxlint|SPDX|Copyright|"
    r"Licen[sc]e|@generated|Code generated|DO NOT EDIT|#!|#region|#endregion|#pragma|"
    r"#include|#define|#ifndef|#ifdef|#endif|#import|shellcheck)",
    re.I,
)


def leaders_for(ext):
    out = []
    if ext in HASH:
        out.append("#")
    if ext in SLASH:
        out += ["//", "/*"]
    if ext in DASH:
        out.append("--")
    if ext in SEMI:
        out.append(";")
    return out


def added_lines(old, new):
    old_set = {ln.rstrip() for ln in (old or "").splitlines()}
    return [ln for ln in (new or "").splitlines() if ln.rstrip() not in old_set]


def is_comment(raw, leaders):
    s = raw.strip()
    if not s:
        return False
    if any(s.startswith(ld) for ld in leaders):
        return True
    if "//" in leaders and re.search(r"(?<!:)\S\s+//", raw):
        return True
    if "#" in leaders and re.search(r"\S\s+#\s", raw):
        return True
    if "--" in leaders and re.search(r"\S\s+--\s", raw):
        return True
    return False


def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        return
    tool = data.get("tool_name", "")
    ti = data.get("tool_input") or {}
    path = ti.get("file_path") or ""
    ext = os.path.splitext(path)[1].lower().lstrip(".")
    leaders = leaders_for(ext)
    if not leaders:
        return

    if tool == "Write":
        lines = (ti.get("content") or "").splitlines()
    elif tool == "Edit":
        lines = added_lines(ti.get("old_string"), ti.get("new_string"))
    elif tool == "MultiEdit":
        lines = []
        for e in ti.get("edits") or []:
            lines += added_lines(e.get("old_string"), e.get("new_string"))
    else:
        return

    flagged = [ln.strip() for ln in lines
               if is_comment(ln, leaders) and not ALLOW.search(ln.strip())]
    if not flagged:
        return

    shown = flagged[:6]
    listing = "\n".join("  " + c[:120] for c in shown)
    if len(flagged) > len(shown):
        listing += f"\n  …and {len(flagged) - len(shown)} more"

    msg = (
        f"[comment-audit] You just added {len(flagged)} comment(s) to "
        f"{os.path.basename(path)}. Default is NO comment. Before continuing, delete any "
        "that restate code, narrate how it works, mark a section, reference the "
        "change/task/caller, or run longer than one line. Keep only a genuine one-line "
        "*why* (constraint, workaround, surprising behavior) or an allowed pragma. "
        "Fix them now with Edit — don't wait to be asked:\n" + listing
    )
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PostToolUse",
            "additionalContext": msg,
        },
        "suppressOutput": True,
    }))


if __name__ == "__main__":
    main()
