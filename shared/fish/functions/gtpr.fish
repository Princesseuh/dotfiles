function gtpr --description "New worktree checked out to a PR (via gh pr checkout), ready to push back"
    if test (count $argv) -lt 1
        echo "usage: gtpr <pr-number> [gh pr checkout args...]" >&2
        return 1
    end

    set -l number $argv[1]
    set -l base (_gt_base); or return 1
    set -l dir "$base/pr-$number"

    # Already have it — just jump in.
    if test -d "$dir"
        cd "$dir"
        return
    end

    # Detached worktree so gh's own checkout can create/switch the PR branch inside it;
    # gh sets up the upstream/push config so `git push` goes back to the PR.
    git worktree add --detach "$dir"
    and cd "$dir"
    and gh pr checkout $number $argv[2..]
    or begin
        # Roll back the empty worktree if the checkout failed.
        test -d "$dir"; and git worktree remove --force "$dir" 2>/dev/null
        return 1
    end
end

complete -c gtpr -f -a '(gh pr list --limit 30 --json number,title --template "{{range .}}{{.number}}\t{{.title}}{{\"\\n\"}}{{end}}" 2>/dev/null)'
