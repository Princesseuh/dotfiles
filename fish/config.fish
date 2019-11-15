# Fish settings
set fish_greeting ""
set fish_color_search_match --background='333'

# Load Fisher plugins
for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end

# Load local config
source $HOME/.config/fish/local.fish

starship init fish | source