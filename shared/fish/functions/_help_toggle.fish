function _help_toggle
    set -l buf (commandline)
    if string match -q '* --help' -- $buf
        commandline -r (string replace -- ' --help' '' $buf)
    else
        commandline -r "$buf --help"
    end
end
