if status --is-interactive
    abbr    --global        c               clear
    abbr    --global        dots            cd $HOME/dotfiles
    abbr    --global        work            cd $HOME/work

    # Git stuff
    abbr    --global        gs              git status
    abbr    --global        ga.             git add .
    abbr    --global        gaa             git add -A
    abbr    --global        gm              git commit -m
    abbr    --global        gp              git push
    abbr    --global        cg              "cd (git rev-parse --show-toplevel)"
end