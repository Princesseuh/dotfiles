function gtrm --description "Remove a worktree by branch name"
    if test (count $argv) -ne 1
        echo "usage: gtrm <branch>" >&2
        return 1
    end

    set -l target $argv[1]
    set -l slug (string replace -a / - -- $target)
    set -l base (_gt_base)
    set -l dir
    if test -n "$base" -a -d "$base/$slug"
        set dir "$base/$slug"
    else
        set dir (git worktree list | string match -e -- "[$target]" | string match -rg '^(\S+)')[1]
    end

    if test -z "$dir"
        echo "gtrm: no worktree for '$target'" >&2
        return 1
    end

    set -l main_root (git worktree list --porcelain | string match -rg '^worktree (.*)$')[1]
    if string match -q -- "$dir*" (pwd)
        cd "$main_root"
    end

    git worktree remove $dir
end

complete -c gtrm -f -a "(git worktree list --porcelain | string match -rg 'branch refs/heads/(.*)')"
