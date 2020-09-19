if status --is-interactive
    abbr    --global        c               clear

    # cd shortcuts
    abbr    --global        dots            cd $HOME/dotfiles
    abbr    --global        work            cd $HOME/work

    # Git stuff
    abbr    --global        gs              git status
    abbr    --global        ga              git add
    abbr    --global        ga.             git add .
    abbr    --global        gaa             git add -A
    abbr    --global        gm              git commit -m
    abbr    --global        gca             git commit --amend
    abbr    --global        gp              git push
    abbr    --global        gd              git diff
    abbr    --global        cg              "cd (git rev-parse --show-toplevel)"

    # Misc
    abbr    --global        m               math
    abbr    --global        eng             LC_ALL=C
end
