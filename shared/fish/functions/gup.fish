function gup --description "Fetch and rebase (or merge) onto origin's default branch"
    set -l default_branch (git rev-parse --abbrev-ref origin/HEAD | string replace 'origin/' '')
    git fetch origin $default_branch
    if contains -- --merge $argv
        git merge origin/$default_branch
    else
        git rebase origin/$default_branch
    end
end
