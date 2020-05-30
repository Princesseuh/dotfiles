set -l commands window zone focused-output full

complete -f -c screenshot
complete -f -c screenshot -n "not __fish_seen_subcommand_from $commands" -a "window" --description 'Screenshot a specific window'
complete -f -c screenshot -n "not __fish_seen_subcommand_from $commands" -a "zone" --description 'Screenshot a zone'
complete -f -c screenshot -n "not __fish_seen_subcommand_from $commands" -a "focused-output" --description 'Screenshot the currently focused output'
complete -f -c screenshot -n "not __fish_seen_subcommand_from $commands" -a "full" --description 'Screenshot the whole desktop'