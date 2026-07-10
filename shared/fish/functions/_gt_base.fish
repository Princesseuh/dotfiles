function _gt_base --description "Print this repo's worktrees dir (~/worktrees/<repo>)"
    # ~/worktrees/<repo> mirrors herdr's [worktrees] directory; keep in sync with it.
    set -l main_root (git worktree list --porcelain 2>/dev/null | string match -rg '^worktree (.*)$')[1]
    test -n "$main_root"; or return 1
    echo $HOME/worktrees/(path basename $main_root)
end
