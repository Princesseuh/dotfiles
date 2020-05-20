cat ~/.cache/wal/sequences &

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
       	sway
	# exec startx -- -keeptty
    end
end

# Fish settings
set fish_greeting ""
set fish_color_search_match --background='333'

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
else
    # Load Fisher plugins
    for file in $fisher_path/conf.d/*.fish
        builtin source $file 2> /dev/null
    end
end

# Load local config
source $HOME/.config/fish/local.fish

starship init fish | source
