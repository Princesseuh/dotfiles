if status --is-interactive
    cat ~/.cache/wal/sequences &
end

# Start Sway at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
       	launch-sway
    end
end

# Fish settings
set -U fish_greeting

# Colors
set fish_color_command 5863A6
set fish_color_param 5F68A1
set fish_color_error A84055
set fish_color_quote 6753A6
set fish_color_escape 9E80FF
set fish_color_search_match --background='605C73'
set fish_pager_color_description 928181
set fish_pager_color_completion d1b9b9
set fish_pager_color_progress d1b9b9 --background='48425D'

if status --is-interactive
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
end
