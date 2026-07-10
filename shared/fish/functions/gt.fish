function gt --description "List worktrees, or switch to / create one by branch name"
    if test (count $argv) -eq 0
        git worktree list
        return
    end

    set -l target $argv[1]
    set -l slug (string replace -a / - -- $target)
    set -l base (_gt_base)

    if test -n "$base" -a -d "$base/$slug"
        cd "$base/$slug"
        return
    end

    set -l dir (git worktree list | string match -e -- "[$target]" | string match -rg '^(\S+)')[1]
    if test -n "$dir" -a -d "$dir"
        cd "$dir"
        return
    end

    if git show-ref --verify --quiet refs/heads/$target
        git worktree add $base/$slug $target
        and cd "$base/$slug"
        return
    end

    if git show-ref --verify --quiet refs/remotes/origin/$target
        git worktree add -b $target $base/$slug origin/$target
        and cd "$base/$slug"
        return
    end

    echo "gt: no worktree or branch '$target' (use gtb/gtm to make a new branch)" >&2
    return 1
end

complete -c gt -f -a '(git for-each-ref --sort=-committerdate refs/heads --format="%(refname:short)")'
