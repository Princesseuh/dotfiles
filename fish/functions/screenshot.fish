function screenshot --description "screenshot <window|focused-output|zone|full>"
    for option in $argv
        switch "$option"
            case window
                grim -g (swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp) -t png - | wl-copy -t image/png
            case focused-output
                grim -o (swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') - | wl-copy -t image/png
            case zone
                grim -g (slurp -d) -t png - | wl-copy -t image/png
            case full
                grim - | wl-copy -t image/png
        end
    end
end