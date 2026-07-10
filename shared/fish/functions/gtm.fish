function gtm --description "New worktree + branch off origin's default branch (main)"
    if test (count $argv) -ne 1
        echo "usage: gtm <new-branch>" >&2
        return 1
    end

    set -l branch $argv[1]
    set -l slug (string replace -a / - -- $branch)
    set -l base (_gt_base); or return 1
    set -l default_branch (git rev-parse --abbrev-ref origin/HEAD | string replace 'origin/' '')

    git fetch origin $default_branch
    and git worktree add -b $branch $base/$slug origin/$default_branch
    and cd "$base/$slug"
end

complete -c gtm -f
