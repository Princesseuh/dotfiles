# General
abbr    --add         c               clear

# cd shortcuts
abbr    --add         dots            cd $HOME/dotfiles

switch (uname)
case Linux
		abbr    --add         work            cd $HOME/work
case Darwin
		abbr    --add         work            cd $HOME/Projects
end

# Git stuff
abbr    --add         gs              git status
abbr    --add         ga              git add
abbr    --add         ga.             git add .
abbr    --add         gaa             git add -A
abbr    --add         gm              git commit -m
abbr    --add         gca             git commit --amend
abbr    --add         gp              git push
abbr    --add         gd              git diff
abbr    --add         cg              "cd (git rev-parse --show-toplevel)"
abbr 		--add					gca							"gum_commit"
abbr 		--add					gcaa						"git add -A; and gum_commit"
abbr 		--add					gpll						git pull
abbr		--add					gset						"git add -A; and git commit -m 'chore: changeset'"

# Misc
abbr    --add         m               math
abbr    --add         eng             LC_ALL=C
