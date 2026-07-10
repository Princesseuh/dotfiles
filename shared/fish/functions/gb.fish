function gb --description "List branches or switch to branch"
    if test (count $argv) -eq 0
        git branch
    else
        git switch $argv 2>/dev/null; or git switch -c $argv
    end
end

complete -c gb -f -a '(git for-each-ref --sort=-committerdate refs/heads --format="%(refname:short)")'
