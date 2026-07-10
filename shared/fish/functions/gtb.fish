function gtb --description "New worktree + branch off the current HEAD"
    if test (count $argv) -ne 1
        echo "usage: gtb <new-branch>" >&2
        return 1
    end

    set -l branch $argv[1]
    set -l slug (string replace -a / - -- $branch)
    set -l base (_gt_base); or return 1

    git worktree add -b $branch $base/$slug
    and cd "$base/$slug"
end

complete -c gtb -f
